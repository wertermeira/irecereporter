class Banner < ApplicationRecord
  KINDS = { full_top: 1, full_bottom: 2 }.freeze

  enum kind: KINDS, _prefix: :kind

  has_one_attached :banner

  validates :name, :date_start, :date_end, :kind, presence: true
  validates :name, length: { maximum: 200 }
  validates :banner, attached: true, content_type: %w[image/png image/gif image/jpg image/jpeg],
                     size: { less_than: 4.megabytes }
  after_validation :validate_date, if: -> { errors.blank? }

  scope :published, lambda {
                      where('date_start <= :current_date AND date_end >= :current_date AND active = true',
                            current_date: Time.current.to_date)
                    }

  private

  def validate_date
    errors.add(:date_start, 'Não pode ser menor igual ou menor que data final') if date_start >= date_end
  end
end
