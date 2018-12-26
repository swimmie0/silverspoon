# frozen_string_literal: true
class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)
 
        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
        else
          session["devise.#{provider}_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end
  
  [:kakao, :google_oauth2, :naver].each do |provider|
    provides_callback_for provider
  end
 
  def after_sign_in_path_for(resource)
    auth = request.env['omniauth.auth']
    @identity = Identity.find_for_oauth(auth)
    @user = User.find(current_user.id)
    if @user.persisted?
      if @identity.provider == "kakao" || "naver" || "google_oauth2" and @user.sign_in_count == 1 #소셜로 첫가입하면 editsns페이지로/맨첫수정페이지
        edit_user_registration_path
      else #로그인/일반회원가입은 프로필페이지
        home_index_path
      end  
    else
      home_index_path
    end
  end
  
end

