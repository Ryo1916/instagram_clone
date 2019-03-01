# == Route Map
#
#                           Prefix Verb     URI Pattern                             Controller#Action
#                             root GET      /                                       mains#top
#                        mains_top GET      /mains/top(.:format)                    mains#top
#                 new_user_session GET      /users/sign_in(.:format)                users/sessions#new
#                     user_session POST     /users/sign_in(.:format)                users/sessions#create
#             destroy_user_session DELETE   /users/sign_out(.:format)               users/sessions#destroy
# user_facebook_omniauth_authorize GET|POST /users/auth/facebook(.:format)          users/omniauth_callbacks#passthru
#  user_facebook_omniauth_callback GET|POST /users/auth/facebook/callback(.:format) users/omniauth_callbacks#facebook
#                new_user_password GET      /users/password/new(.:format)           users/passwords#new
#               edit_user_password GET      /users/password/edit(.:format)          users/passwords#edit
#                    user_password PATCH    /users/password(.:format)               users/passwords#update
#                                  PUT      /users/password(.:format)               users/passwords#update
#                                  POST     /users/password(.:format)               users/passwords#create
#         cancel_user_registration GET      /users/cancel(.:format)                 users/registrations#cancel
#            new_user_registration GET      /users/sign_up(.:format)                users/registrations#new
#           edit_user_registration GET      /users/edit(.:format)                   users/registrations#edit
#                user_registration PATCH    /users(.:format)                        users/registrations#update
#                                  PUT      /users(.:format)                        users/registrations#update
#                                  DELETE   /users(.:format)                        users/registrations#destroy
#                                  POST     /users(.:format)                        users/registrations#create
#                  new_user_unlock GET      /users/unlock/new(.:format)             devise/unlocks#new
#                      user_unlock GET      /users/unlock(.:format)                 devise/unlocks#show
#                                  POST     /users/unlock(.:format)                 devise/unlocks#create
#                            users GET      /users(.:format)                        users#index
#                             user GET      /users/:id(.:format)                    users#show
#                letter_opener_web          /letter_opener                          LetterOpenerWeb::Engine
#
# Routes for LetterOpenerWeb::Engine:
# clear_letters DELETE /clear(.:format)                 letter_opener_web/letters#clear
# delete_letter DELETE /:id(.:format)                   letter_opener_web/letters#destroy
#       letters GET    /                                letter_opener_web/letters#index
#        letter GET    /:id(/:style)(.:format)          letter_opener_web/letters#show
#               GET    /:id/attachments/:file(.:format) letter_opener_web/letters#attachment

Rails.application.routes.draw do
  root 'mains#top'
  get 'mains/top'
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    passwords: "users/passwords",
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, only: [:show, :index, :edit, :update] do
    member do
      get :following, :followers
    end
    resources :relationships, only: [:create, :destroy]
  end
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
