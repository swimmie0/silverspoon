Rails.application.routes.draw do
  resources :userrequests
  get 'home/index'
  root 'home#index'
  resources :zizuminfos
  resources :restaurants
  resources :menus
  devise_for :users

  #크롤링
  get '/crawling' => 'restaurants#crawling'
  # 수영
  #devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }
    ### 수정 / 삭제 요청 ###
  #요청 확인
  get '/userrequests' => 'userrequests#index'
  #메뉴 추가 요청
  get '/userrequests/new_request' => 'userrequests#new_request'
  post '/userrequests/create' => 'userrequests#create'
  #메뉴 수청 / 삭제 요청
  get '/userrequests/edit_request' => 'userrequests#edit_request'
  post '/userrequests/edit_request' => 'userrequests#edit_request'
  #승인
  post '/userrequests/permit' => 'userrequests#permit'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  ## 수정 / 삭제 요청 ###
  #요청 확인
  get '/userrequests' => 'userrequests#index'
  #메뉴 추가 요청
  get '/userrequests/new_request' => 'userrequests#new_request'
  post '/userrequests/create' => 'userrequests#create'
  #메뉴 수청 / 삭제 요청
  get '/userrequests/edit_request' => 'userrequests#edit_request'
  post '/userrequests/edit_request' => 'userrequests#edit_request'
  #승인
  post '/userrequests/permit' => 'userrequests#permit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
