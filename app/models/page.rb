class Page < ApplicationRecord
  belongs_to :category, optional: true
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :posts, dependent: :nullify

  validates :name, presence: true
  validates :name, length: { maximum: 150 }
end
