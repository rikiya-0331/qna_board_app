class CreateQuizHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_histories do |t|
      t.integer :score
      t.integer :total_questions
      t.integer :correct_answers
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
