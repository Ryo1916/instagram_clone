Rails.application.routes.draw do
  root 'mains#top'
  get 'mains/top'

  devise_for :users
end
