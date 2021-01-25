class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :post_categories, dependent: :destroy
  has_many :pages, dependent: :nullify
  has_many :posts, through: :post_categories
  has_many :pages_posts, through: :pages, source: :posts

  validates :name, presence: true
  validates :name, length: { maximum: 150 }

  scope :only_home, -> { where(show_on_home: true) }
end
