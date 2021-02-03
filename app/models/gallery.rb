class Gallery < ApplicationRecord
  belongs_to :post

  has_one_attached :image

  validates :image, content_type: %w[image/png image/gif image/jpg image/jpeg], size: { less_than: 4.megabytes }
end
