FactoryBot.define do
  factory :post_hit do
    post { nil }
    hit_day { '2021-01-27' }
    hits { 1 }
  end
end
