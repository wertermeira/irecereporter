FactoryBot.define do
  factory :post do
    name { "MyString" }
    subname { "MyString" }
    headline { "MyString" }
    body { "MyText" }
    summary { "MyText" }
    active { false }
    feature { false }
  end
end
