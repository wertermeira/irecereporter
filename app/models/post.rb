class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :body, presence: true
  validates :name, :subname, length: { maximum: 140 }
  validates :headline, length: { maximum: 100 }
  validates :summary, length: { maximum: 250 }
end
