# frozen_string_literal: true

FactoryBot.define do
  factory :quiz do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    association :category
  end
end
