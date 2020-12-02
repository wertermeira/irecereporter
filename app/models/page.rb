class Page < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 150 }
end
