Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :titles, only: [:index, :show] do
    resources :rentals, only: [:create, :show, :destroy]
  end

  resources :user, only: [:show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
