class Post < ApplicationRecord
  belongs_to :page, optional: true

  acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :interests

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :galleries, dependent: :destroy

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
  validates :category_ids, presence: true
  validates :cover, :image, content_type: %w[image/png image/gif image/jpg image/jpeg], size: { less_than: 4.megabytes }
end
