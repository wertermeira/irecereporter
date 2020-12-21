FactoryBot.define do
  factory :banner do
    name { Faker::Name.name }
    banner { Rack::Test::UploadedFile.new(File.new("#{Rails.root}/spec/support/fixtures/image.jpg")) }
    date_start { Time.current.to_date }
    date_end { (Time.current + 2.days).to_date }
    active { true }
    kind { Banner::KINDS.keys.sample.to_s }
  end
end
