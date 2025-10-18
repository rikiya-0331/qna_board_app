# frozen_string_literal: true

FactoryBot.define do
  factory :answer_choice do
    content_jp { Faker::Lorem.sentence(word_count: 1) }
    content_en { Faker::Lorem.sentence(word_count: 1) }
    is_correct { false }
    association :question

    trait :correct do
      is_correct { true }
    end
  end
end
