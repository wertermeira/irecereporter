FactoryBot.define do
  password = Faker::Internet.password(min_length: 8)
  factory :admin do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
    active { %w[true false].sample }
    profile { %w[admin editor visitor].sample }
  end
end
