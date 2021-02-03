class Post < ApplicationRecord
  belongs_to :page, optional: true

  acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :interests

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :galleries, dependent: :destroy
  has_many :hits, class_name: 'PostHit', dependent: :destroy, source: :post

  scope :published, -> { where(active: true) }
  scope :feature_posts, -> { where(feature_post: true, active: true) }
  scope :by_category, lambda { |category|
    joins(:post_categories).where('post_categories.category_id = :category_id OR posts.page_id = :page_ids',
                                  category_id: category.id, page_ids: category.pages.ids)
                           .distinct('posts.id')
  }

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one_attached :image
  has_one_attached :cover

  validates :name, :body, presence: true
  validates :name, :subname, :cover_subtitle, :image_subtitle, length: { maximum: 140 }
  validates :headline, length: { maximum: 100 }
  validates :summary, length: { maximum: 250 }
  # validates :category_ids, presence: true
  validates :cover, :image, content_type: %w[image/png image/gif image/jpg image/jpeg],
                            size: { less_than: 10.megabytes }

  def self.top_hits(limit: 10)
    week = (Time.current - 7.days).strftime('%Y-%m-%d')
    query = 'SELECT posts.*, SUM(p_hits.hits) AS total_hits FROM posts '\
            'INNER JOIN post_hits AS p_hits ON p_hits.post_id = posts.id WHERE p_hits.hit_day > :week '\
            'GROUP BY posts.id ORDER BY total_hits DESC LIMIT :limit'
    Post.find_by_sql(sanitize_sql_array([query, { limit: limit, week: week }]))
  end
end
