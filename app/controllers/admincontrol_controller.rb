class AdmincontrolController < ApplicationController
    before_action :authorize_admin
    
    def index
    end
    
    def zizuminfo
    end

    def restaurant
        @restaurants = Restaurant.all
    end

    def resupdate
    end

    def user
    end

end
