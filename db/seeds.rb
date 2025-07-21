# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts '古いデータを削除しています...'
Category.destroy_all
# QuestionモデルはCategoryに紐付いており、dependent: :destroyが設定されているため、
# Categoryを削除すれば関連するQuestionも自動的に削除されます。

puts 'カテゴリを作成しています...'
immigration = Category.create!(name: '入国審査')
customs = Category.create!(name: '税関')
baggage_transfer = Category.create!(name: '手荷物・乗り継ぎ')

puts 'Q&Aデータを作成しています...'

# --- 入国審査 ---
Question.create!([
  {
    category: immigration,
    title_jp: '訪問の目的は何ですか？',
    title_en: 'What is the purpose of your visit?',
    answer_jp: '観光です。／仕事です。',
    answer_en: "I'm here for sightseeing. / I'm here for business."
  },
  {
    category: immigration,
    title_jp: 'どのくらい滞在する予定ですか？',
    title_en: 'How long will you be staying?',
    answer_jp: '2週間滞在します。',
    answer_en: "I'll be staying for two weeks."
  },
  {
    category: immigration,
    title_jp: 'どこに滞在しますか？',
    title_en: 'Where will you be staying?',
    answer_jp: 'ABCホテルに滞在します。',
    answer_en: "I'll be staying at the ABC Hotel."
  },
  {
    category: immigration,
    title_jp: '帰りの航空券はお持ちですか？',
    title_en: 'Do you have a return ticket?',
    answer_jp: 'はい、持っています。こちらです。',
    answer_en: 'Yes, I do. Here it is.'
  },
  {
    category: immigration,
    title_jp: '職業は何ですか？',
    title_en: 'What is your occupation?',
    answer_jp: '会社員です。／学生です。',
    answer_en: "I'm an office worker. / I'm a student."
  }
])

# --- 税関 ---
Question.create!([
  {
    category: customs,
    title_jp: '申告するものはありますか？',
    title_en: 'Do you have anything to declare?',
    answer_jp: 'いいえ、ありません。／はい、あります。',
    answer_en: 'No, nothing. / Yes, I do.'
  },
  {
    category: customs,
    title_jp: '現金は1万ドル以上持っていますか？',
    title_en: 'Are you carrying over $10,000 in cash?',
    answer_jp: 'いいえ、持っていません。',
    answer_en: 'No, I am not.'
  },
  {
    category: customs,
    title_jp: '食べ物や植物、肉製品を持っていますか？',
    title_en: 'Are you bringing any food, plants, or meat products?',
    answer_jp: 'いいえ、持っていません。',
    answer_en: 'No, I am not.'
  },
  {
    category: customs,
    title_jp: 'ご自身で荷造りしましたか？',
    title_en: 'Did you pack your bags yourself?',
    answer_jp: 'はい、自分でしました。',
    answer_en: 'Yes, I packed them myself.'
  },
  {
    category: customs,
    title_jp: 'お酒やタバコは持っていますか？',
    title_en: 'Are you carrying any alcohol or tobacco?',
    answer_jp: '免税範囲内の量だけ持っています。／いいえ、持っていません。',
    answer_en: "Yes, within the duty-free allowance. / No, I'm not."
  }
])

# --- 手荷物・乗り継ぎ ---
Question.create!([
  {
    category: baggage_transfer,
    title_jp: '手荷物はどこで受け取れますか？',
    title_en: 'Where can I claim my baggage?',
    answer_jp: 'あちらの手荷物受取所で受け取れます。電光掲示板でご利用の便名を探してください。',
    answer_en: 'You can claim it at the baggage claim area over there. Please find your flight number on the information board.'
  },
  {
    category: baggage_transfer,
    title_jp: '乗り継ぎカウンターはどこですか？',
    title_en: 'Where is the transfer desk?',
    answer_jp: 'まっすぐ進んで右手にあります。',
    answer_en: 'Go straight and it will be on your right.'
  },
  {
    category: baggage_transfer,
    title_jp: '私の荷物が見つかりません。',
    title_en: "I can't find my luggage.",
    answer_jp: '手荷物サービスカウンターで紛失の報告をしてください。',
    answer_en: 'Please report it at the baggage service counter.'
  },
  {
    category: baggage_transfer,
    title_jp: '次のフライトのために、荷物を再度預ける必要はありますか？',
    title_en: 'Do I need to re-check my luggage for my connecting flight?',
    answer_jp: '航空会社のカウンターでご確認ください。最終目的地までスルーチェックインされている場合もあります。',
    answer_en: 'Please check with your airline counter. It may be checked through to your final destination.'
  },
  {
    category: baggage_transfer,
    title_jp: '第2ターミナルへはどう行けばいいですか？',
    title_en: 'How can I get to Terminal 2?',
    answer_jp: '無料のシャトルバスが5分おきに運行しています。',
    answer_en: 'There is a free shuttle bus that runs every 5 minutes.'
  }
])

puts 'シードデータの作成が完了しました。'
