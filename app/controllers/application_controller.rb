class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    #after_action :store_location

    # protect_from_forgery with: :exception
    protect_from_forgery prepend: true
    protected

    def authorize_admin
      redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
    end
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender, :email, :IDe, :password,:profileimg, :ages, :isExpert, :allergy_etc, allergy:[] ] )
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender, :email, :IDe, :password,:profileimg, :ages, :isExpert, :allergy_etc, allergy:[] ])
    end
    
    #######로그인 한 이후 원래 머무르던 창으로 되돌아가기 #######
    # def store_location
    #   session[:previous_urls] ||= []
    #   # store unique urls only
    #   session[:previous_urls].prepend request.fullpath if session[:previous_urls].first != request.fullpath
    #   # For Rails < 3.2
    #   # session[:previous_urls].unshift request.fullpath if session[:previous_urls].first != request.fullpath 
    #   session[:previous_urls].pop if session[:previous_urls].count > 2
    # end
    # def after_sign_in_path_for(resource)
    #   session[:previous_urls].last || root_path
    # end
    ###########################################################

    
  end
  