FactoryBot.define do
  factory :post do
    name { Faker::Lorem.sentence(word_count: 3) }
    subname { Faker::Lorem.sentence(word_count: 3) }
    headline { Faker::Lorem.sentence(word_count: 1) }
    body { Faker::Lorem.sentence(word_count: 10) }
    summary { Faker::Lorem.sentence(word_count: 5) }
    active { true }
    feature { %w[true false].sample }

    before :create do |post|
      post.category_ids = create_list(:category, rand(2..10)).pluck(:id)
    end
  end
end
