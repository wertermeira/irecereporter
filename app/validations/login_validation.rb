class LoginValidation
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :email, :password

  validates :email, :password, presence: true
  validates :email, email: true, allow_blank: true
end
