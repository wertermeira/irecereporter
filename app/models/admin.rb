class Admin < ApplicationRecord
  has_secure_password

  enum profile: { admin: 0, editor: 1, visitor: 2 }

  validates :password, confirmation: true, allow_blank: true
  validates :name, :email, :profile, presence: true
  validates :password, :password_confirmation, presence: true, on: :create
  validates :password, :password_confirmation, length: { in: 6..20 }, allow_blank: true
  validates :name, length: { maximum: 50 }
  validates :email, uniqueness: true
  validates :email, email: true

  before_create :generate_token, :save_email_downcase

  private

  def save_email_downcase
    self.email = email.downcase
  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.alphanumeric(100)
      break random_token unless Admin.exists?(token: random_token)
    end
  end
end
