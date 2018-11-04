Rails.application.routes.draw do
  devise_for :users

  # 수영
  #devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
