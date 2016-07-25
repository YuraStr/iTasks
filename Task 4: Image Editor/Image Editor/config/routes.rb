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

  get 'application/save_image' => 'application#save_image', as: :save_image

  match 'users/:user_id/uploads/update' => 'uploads#update', :via => :post
end
