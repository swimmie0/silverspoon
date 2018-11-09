class FollowsController < ApplicationController

    def article_destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to profile_url(current_user.profile.id)
    end

    def profile_follow_destroy_toggle
        @zizum = Zizuminfo.find(params[:id])
        current_user.stop_following(@zizum) 

        redirect_to profile_url(current_user.profile.id)
    end 

    def article_follow_toggle
        @article = Article.find(params[:id])
        if @article.followed_by?(current_user)
            current_user.stop_following(@article)

        else !@article.followed_by?(current_user)
            current_user.follow(@article)
        end 
            redirect_to article_url(@article.id)
    end

    def article_follow_destroy_toggle
        @article = Article.find(params[:id])
        current_user.stop_following(@article) 

        redirect_to profile_url(current_user.profile.id)
    end 

    def zizum_front_follow_toggle

        @zizum = Zizuminfo.find(params[:id])
        
        if @zizum.followed_by?(current_user)
            current_user.stop_following(@zizum)
        else !@zizum.followed_by?(current_user)
            current_user.follow(@zizum)
        end 
            # redirect_to zizum_path(@zizum.id)
    end

    def zizum_back_follow_toggle

        @zizum = Zizuminfo.find(params[:id])
        
        # where(:restaurant_name => @restaurants.map(&:restaurant_name)
        if @zizum.followed_by?(current_user)
            current_user.stop_following(@zizum)

        else !@zizum.followed_by?(current_user)
            current_user.follow(@zizum)          
        end 
            redirect_to zizuminfo_url(@zizum.id) 
    end
end
