# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    name { Faker::Music.band }
  end
end
