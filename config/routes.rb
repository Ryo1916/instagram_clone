Rails.application.routes.draw do
  root 'mains#top'
  get 'mains/top'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    passwords: "users/passwords",
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
