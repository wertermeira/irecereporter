class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :post_categories, dependent: :destroy
  has_many :pages, dependent: :nullify
  has_many :category_posts, through: :post_categories, source: :post
  has_many :pages_posts, through: :pages, source: :posts

  validates :name, presence: true
  validates :name, length: { maximum: 150 }

  scope :only_home, -> { where(show_on_home: true) }

  def posts
    Post.where(id: by_category_posts.ids).or(Post.where(id: pages_posts.ids)).uniq
  end
end
