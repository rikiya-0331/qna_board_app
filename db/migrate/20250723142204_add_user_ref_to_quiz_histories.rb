class AddUserRefToQuizHistories < ActiveRecord::Migration[7.1]
  def change
    add_reference :quiz_histories, :user, type: :uuid, null: true, foreign_key: true
  end
end
