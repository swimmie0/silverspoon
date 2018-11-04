Rails.application.routes.draw do
  resources :freeboards
  get 'home/index'

  # 수영
  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks' }
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
