class CreateQuizResults < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_results, id: :uuid do |t|
      t.boolean :is_correct
      t.references :selected_answer_choice, type: :uuid, null: false, foreign_key: { to_table: :answer_choices }
      t.references :quiz_history, type: :uuid, null: false, foreign_key: true
      t.references :question, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
