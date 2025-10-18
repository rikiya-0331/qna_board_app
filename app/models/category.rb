# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :questions, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
