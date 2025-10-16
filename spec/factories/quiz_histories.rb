FactoryBot.define do
  factory :quiz_history do
    score { Faker::Number.number(digits: 2) }
    total_questions { 10 }
    correct_answers { Faker::Number.between(from: 0, to: 10) }
    association :category
    association :user
  end
end
