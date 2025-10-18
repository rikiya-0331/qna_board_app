# frozen_string_literal: true

class User < ApplicationRecord
  has_many :quiz_histories, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_questions, through: :favorites, source: :question
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def favorited?(question)
    favorite_questions.include?(question)
  end

  def admin?
    admin
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[admin created_at email id name provider uid updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[favorite_questions favorites quiz_histories]
  end
end
