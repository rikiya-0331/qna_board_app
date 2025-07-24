class User < ApplicationRecord
  has_many :quiz_histories, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_questions, through: :favorites, source: :question
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
