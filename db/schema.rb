# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_07_24_003651) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_choices", force: :cascade do |t|
    t.text "content_jp"
    t.text "content_en"
    t.boolean "is_correct"
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answer_choices_on_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_favorites_on_question_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "title_jp"
    t.text "title_en"
    t.text "answer_jp"
    t.text "answer_en"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_questions_on_category_id"
  end

  create_table "quiz_histories", force: :cascade do |t|
    t.integer "score"
    t.integer "total_questions"
    t.integer "correct_answers"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["category_id"], name: "index_quiz_histories_on_category_id"
    t.index ["user_id"], name: "index_quiz_histories_on_user_id"
  end

  create_table "quiz_results", force: :cascade do |t|
    t.boolean "is_correct"
    t.bigint "selected_answer_choice_id", null: false
    t.bigint "quiz_history_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_quiz_results_on_question_id"
    t.index ["quiz_history_id"], name: "index_quiz_results_on_quiz_history_id"
    t.index ["selected_answer_choice_id"], name: "index_quiz_results_on_selected_answer_choice_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_quizzes_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answer_choices", "questions"
  add_foreign_key "favorites", "questions"
  add_foreign_key "favorites", "users"
  add_foreign_key "questions", "categories"
  add_foreign_key "quiz_histories", "categories"
  add_foreign_key "quiz_histories", "users"
  add_foreign_key "quiz_results", "answer_choices", column: "selected_answer_choice_id"
  add_foreign_key "quiz_results", "questions"
  add_foreign_key "quiz_results", "quiz_histories"
  add_foreign_key "quizzes", "categories"
end
