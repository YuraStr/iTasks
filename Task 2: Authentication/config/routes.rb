Rails.application.routes.draw do
  namespace :users do
    get 'omniauth_callbacks/facebook'
  end

  namespace :users do
    get 'omniauth_callbacks/vkontakte'
  end
  namespace :users do
    get 'omniauth_callbacks/twitter'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:index, :destroy]
  root :to => 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
