# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'title/random', to: 'titles#random'
  get '/rick', to: 'pages#rick'


  resources :titles, only: [:index, :show] do
    resources :rentals, only: [:create, :new]
  end
  resources :rentals, only: [:index, :show, :destroy, :edit, :update]
  resources :users, only: [:show, :edit, :update, :index]
end
