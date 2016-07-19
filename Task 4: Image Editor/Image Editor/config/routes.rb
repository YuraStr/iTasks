Rails.application.routes.draw do
  get 'uploads/new'

  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do
    resources :uploads
  end

  root "users#index"
end
