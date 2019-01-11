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

    # def zizum_front_follow_toggle

    #     @zizum = Zizuminfo.find(params[:id])
        
    #     if @zizum.followed_by?(current_user)
    #         current_user.stop_following(@zizum)
    #     else !@zizum.followed_by?(current_user)
    #         current_user.follow(@zizum)
    #     end 
    #         # redirect_to zizum_path(@zizum.id)
    # end

    # def zizum_back_follow_toggle

    #     @zizum = Zizuminfo.find(params[:id])
        
    #     # where(:restaurant_name => @restaurants.map(&:restaurant_name)
    #     if @zizum.followed_by?(current_user)
    #         current_user.stop_following(@zizum)

    #     else !@zizum.followed_by?(current_user)
    #         current_user.follow(@zizum)          
    #     end 
    #         redirect_to zizuminfo_url(@zizum.id) 
    # end

    def zizumfollow
        @zizum = Zizuminfo.find(params[:id])
        followtype = false
        
        if @zizum.followed_by?(current_user)
            current_user.stop_following(@zizum)
        else
            current_user.follow(@zizum)
            followtype = true
        end

        $result = {"zizumid" => nil, "follow" => nil}
        $result["zizumid"] = @zizum.id
        $result["follow"] = followtype

        respond_to do |format|
            format.json {render json: $result}
        end
    end

  def getGungu
    #받아오기
    @locations = JSON.parse(File.read(File.join('sigungu.json')))

    @sido_name = params[:sido]
    @sigungu_name = @locations["data"][0][@sido_name]

    $result={"sido_name" => nil, "sigungu_name"=>nil}
    $result["sido_name"]=@sido_name
    $result["sigungu_name"]=@sigungu_name
    
    $result = $result.to_json
    puts "실험실험실험============================================="
    puts $result
    puts "싫끝====================================================="

    respond_to do |format|
      format.json {render json: $result}
    end
  end
end
