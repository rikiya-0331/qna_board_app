# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title_jp { Faker::Lorem.sentence(word_count: 3) }
    title_en { Faker::Lorem.sentence(word_count: 3) }
    answer_jp { Faker::Lorem.sentence(word_count: 5) }
    answer_en { Faker::Lorem.sentence(word_count: 5) }
    association :category
  end
end
