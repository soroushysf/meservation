Rails.application.routes.draw do
  resources :categories
  resources :restaurants do
    resources :reservations, only: [:create, :destroy]
    # resources :stars, only: [:new, :create, :destroy]
    put :star, on: :member
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'restaurants#index'

  get '/dashboard', to: 'users#dashboard', as: "authenticated_root"

  get '/my-stars', to: 'users#my_stars', as: "my_stars"
end
