# frozen_string_literal: true

class Quiz < ApplicationRecord
  belongs_to :category
  has_many :questions, dependent: :destroy
end
