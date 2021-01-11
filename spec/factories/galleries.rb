FactoryBot.define do
  factory :gallery do
    post { create(:post) }
  end
end
