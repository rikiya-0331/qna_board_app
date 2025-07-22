class CreateAnswerChoices < ActiveRecord::Migration[7.1]
  def change
    create_table :answer_choices do |t|
      t.text :content_jp
      t.text :content_en
      t.boolean :is_correct
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
