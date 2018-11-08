class ProfileController < ApplicationController
    def show
        @profile_id = current_user.id
    end 
end
