Rails.application.routes.draw do

  resources :notices

  resources :conversations do
    resources :messages
  end

  get 'legal/privacy' => "legal#privacy"
  get 'legal/using' => "legal#using"
  #PROFILE------FOLLOW/UNFOLLOW
  get 'profiles/:id/follow' => 'follows#profile_follow', as: 'profile_follow'
  
  ##SEARCH------resources :zizuminfos 보다 위에
  get 'zizuminfos/search/' => "zizuminfos#search"
  post 'zizuminfos/getZizum' => "zizuminfos#getZizum"
  get 'zizuminfos/getGungu' => "menus#getGungu"
  get 'zizuminfos/zizummenus' => "zizuminfos#zizummenus"
  get 'zizuminfos/:id/show' => "zizuminfos#show"
  #밑에 꺼 꼭 넣어야함.
  get 'zizuminfos/index' => "zizuminfos#index", as: 'zizuminfos'
  ##-------------------------------------


  #SEARCH----------resouces :menus 보다 위에 가게 해야 함! --------------------
  get 'restaurants/search' => "restaurants#search"
  get 'menus/search/' => "menus#search"
  get 'menus/getGungu' => "menus#getGungu"
  get 'menus/menus/getGungu' => "menus#getGungu"
  get 'zizuminfos/getGungu' => "menus#getGungu"
  #밑에 꺼 꼭 넣어야함.
  get 'menus/index' => "menus#index", as: 'menus'
  #--------------------------------------------------------------------------

  #-----------------좋아요 ajax
  get 'follows/zizumfollow' => "follows#zizumfollow"
  get 'follows/recipefollow' => "follows#recipefollow"
  
  #-----------admin 관리 페이지
  get 'admincontrol/index' => "admincontrol#index"
  get 'admincontrol/zizuminfo' => "admincontrol#zizuminfo"
  get 'admincontrol/menu' => "admincontrol#menu"
  get 'admincontrol/restaurant' => "admincontrol#restaurant"
  get 'admincontrol/zizumupdate' => "admincontrol#zizumupdate"
  get 'admincontrol/resupdate' => "admincontrol#resupdate"
  get 'admincontrol/menuupdate' => "admincontrol#menuupdate"
  #===============메뉴별 제보 요청==============
 get 'userrequests/index'

 get 'userrequests/new'

 get 'userrequests/ask'

 get 'edit_asks/index'
 
 get 'edit_asks/ask'
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
  #=================================
  
  # 나만의 페이지
  resources :profiles
  # post '/profiles/:id/myposts' => 'profiles#myposts'
  scope 'profiles/:id' do
    get 'myposts', :to => 'profiles#myposts'
  end
  get '/zizuminfos/:id/follow_destroy', to: 'follows#profile_follow_destroy_toggle', as: 'profile_follow_destroy'

  # # Follow 기능
  # post '/zizuminfos/:id/follow', to: 'follows#zizum_back_follow_toggle', as: 'zizum_back_follow'
  # post '/menus/index/params', to: 'follows#zizum_front_follow_toggle', as: 'zizum_front_follow'

  # get '/freeboards/'
  resources :recipes
  resources :freeboards
  resources :userrequests
  resources :zizuminfos
  resources :restaurants
  resources :menus

  get 'home/index'
  root 'home#index'

  #============크롤링===============
  get '/crawling' => 'restaurants#crawling'
  #================================
  post '/tinymce_assets' => 'tinymce_assets#create'
  # user
  # post '/users/checkDouble' => 'user/registrations#checkDouble'
  # post "/users/checkDouble" => "user/registrations#checkDouble" 
  devise_scope :user do
     post "/users/checkDouble" => "user/registrations#checkDouble" 
     post "/checkDouble" => "user/registrations#checkDouble"
     get "/users" => 'user/registrations#new'
  end
  devise_for :users, :controllers => {registrations: 'user/registrations' }
  devise_scope :user do
    get 'editsns', :to => 'devise/registrations#editsns'
  end
  # resources :comments, only: [:create, :destroy]
  resources :comments do
    member do
      put "like", to: "comments#like"
      put "unvote", to: "comments#unvote" 
      put "dislike", to: "comments#dislike" 
      
    end    
  end


  # 알림
  get '/new_alarms/read_all' => 'new_alarms#read_all'
  resources :new_alarms #순서이대로
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'# 맨아래에 둬주세요
  
  # concern :paginatable do
  #   get '(page/:page)', action: :index, on: :collection, as: ''
  # end
  
  # resources :my_resources, concerns: :paginatable
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
