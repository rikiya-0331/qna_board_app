Rails.application.routes.draw do
  resources :questions do
    resource :favorites, only: [:create, :destroy]
  end
  resources :quizzes do
    member do
      get :detail
    end
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users
  root 'questions#index'

  # マイページへのルーティング
  resource :mypage, only: [:show]

  # クイズ履歴の詳細ページへのルーティング
  resources :quiz_histories, only: [:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get '/quiz/start', to: 'quizzes#start'
  post '/quiz/start', to: 'quizzes#create'
  get '/quiz/results', to: 'quizzes#results'
  get '/quiz/:id', to: 'quizzes#show', as: 'quiz_question'
  post '/quiz/:id/answer', to: 'quizzes#answer', as: 'quiz_answer'
end