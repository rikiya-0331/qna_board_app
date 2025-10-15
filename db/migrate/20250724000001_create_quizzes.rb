class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes, id: :uuid do |t|
      t.string :title
      t.text :description
      t.references :category, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
