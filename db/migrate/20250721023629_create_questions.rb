class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.text :title_jp
      t.text :title_en
      t.text :answer_jp
      t.text :answer_en
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
