# frozen_string_literal: true

puts '古いデータを削除しています...'
QuizResult.destroy_all
AnswerChoice.destroy_all
Question.destroy_all
QuizHistory.destroy_all
Category.destroy_all
User.destroy_all # Userも削除
AdminUser.destroy_all # AdminUserも削除

puts 'カテゴリを作成しています...'
immigration = Category.create!(name: '入国審査')
customs = Category.create!(name: '税関')
baggage_transfer = Category.create!(name: '手荷物・乗り継ぎ')

puts 'Q&Aデータと選択肢を作成しています...'

# --- 入国審査 ---
q1 = Question.create!(
  category: immigration,
  title_jp: '訪問の目的は何ですか?',
  title_en: 'What is the purpose of your visit?',
  answer_jp: '観光です。',
  answer_en: "I'm here for sightseeing."
)
AnswerChoice.create!([
  { question: q1, content_jp: '観光です', content_en: 'For sightseeing', is_correct: true },
  { question: q1, content_jp: '乗り継ぎです', content_en: 'For transit', is_correct: false },
  { question: q1, content_jp: '永住です', content_en: 'For permanent residence', is_correct: false },
  { question: q1, content_jp: 'わかりません', content_en: 'I don\'t know', is_correct: false }
])

q2 = Question.create!(
  category: immigration,
  title_jp: 'どのくらい滞在する予定ですか?',
  title_en: 'How long will you be staying?',
  answer_jp: '2週間滞在します。',
  answer_en: "I'll be staying for two weeks."
)
AnswerChoice.create!([
  { question: q2, content_jp: '2週間です', content_en: 'For two weeks', is_correct: true },
  { question: q2, content_jp: '半年です', content_en: 'For six months', is_correct: false },
  { question: q2, content_jp: '1日です', content_en: 'For one day', is_correct: false },
  { question: q2, content_jp: '未定です', content_en: 'It is undecided', is_correct: false }
])

# --- 税関 ---
q3 = Question.create!(
  category: customs,
  title_jp: '申告するものはありますか?',
  title_en: 'Do you have anything to declare?',
  answer_jp: 'いいえ、ありません。',
  answer_en: 'No, nothing.'
)
AnswerChoice.create!([
  { question: q3, content_jp: 'ありません', content_en: 'No, nothing', is_correct: true },
  { question: q3, content_jp: '現金1万ドル', content_en: '$10,000 in cash', is_correct: false },
  { question: q3, content_jp: '果物', content_en: 'Fruits', is_correct: false },
  { question: q3, content_jp: '肉製品', content_en: 'Meat products', is_correct: false }
])

# 他にも必要に応じて質問と選択肢を追加できます

puts 'シードデータの作成が完了しました。'
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true) if Rails.env.development?
AdminUser.create!(email: 'admin@admin.com', password: 'password', password_confirmation: 'password') if Rails.env.development?