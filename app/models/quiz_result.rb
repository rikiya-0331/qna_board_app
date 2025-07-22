class QuizResult < ApplicationRecord
  belongs_to :quiz_history
  belongs_to :question
  belongs_to :selected_answer_choice, class_name: 'AnswerChoice', optional: true
end
