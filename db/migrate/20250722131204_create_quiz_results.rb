class CreateQuizResults < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_results do |t|
      t.boolean :is_correct
            t.references :selected_answer_choice, null: false, foreign_key: { to_table: :answer_choices }
      t.references :quiz_history, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
