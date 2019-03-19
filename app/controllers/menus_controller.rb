class MenusController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, except: [:index, :show, :getGungu]

  require 'open-uri'
  require 'json'
  # GET /menus
  # GET /menus.json

  #로그인 팝업창
  #메뉴로 검색
  def search
  end

  def index
    #오늘의 추천식당- daily random
    # day_today = Time.now.day
    # rule = day_today % Restaurant.count
    # @today_restaurants = Restaurant.where(id: [rule-1, rule, rule+1] )
    
    # 총 식당- updated_at order
    @current_restaurants = Restaurant.order("created_at desc").limit(9);
    # 총지점
    @zizuminfos = Zizuminfo.all.order("created_at DESC");
    @tot_zizums = Kaminari.paginate_array(@zizuminfos).page(params[:page]).per(9)

    # 체크 안했을 경우-알러지 없다. / check 하면 true(알러지없다). a1, a2 등은 알러지 없다고 표시 되면 1 
     sido = params[:sido]
     sigungu = params[:sigungu]

    #  puts "============="+allergy

    
     a1=0
     a2=0
     a3=0 
     a4=0
     a5=0
     a6=0
     a7=0
     a8=0
     a9=0
     a10=0
     a11=0
     a12=0
     a13=0
     a14=0
     a15=0
     a16=0
     a17=0
     a18=0
     a19=0
     a20=0
     a21=0
 
     # ----------------search 시에 체크-----------------------
     a1 = 2 if params[:a1_maemil] != "true" # 체크 안했을 경우-알러지 없다. / check 하면 true(알러지없다). a1, a2 등은 알러지 없다고 표시 되면 1 
     a2 = 2 if params[:a2_mil] != "true"
     a3 = 2 if params[:a3_daedu] != "true"
     a4 = 2 if params[:a4_hodu] != "true"
     a5 = 2 if params[:a5_ddangkong] != "true"
     a6 = 2 if params[:a6_peach] != "true"
     a7 = 2 if params[:a7_tomato] != "true"
     a8 = 2 if params[:a8_piggogi] != "true"
     a9 = 2 if params[:a9_nanryu] != "true" 
     a10 = 2 if params[:a10_milk] != "true"
     a11 = 2 if params[:a11_ddakgogi] != "true"
     a12 = 2 if params[:a12_shoigogi] != "true"
     a13 = 2 if params[:a13_saewoo] != "true"
     a14 = 2 if params[:a14_godeungeoh] != "true"
     a15 = 2 if params[:a15_honghap] != "true"
     a16 = 2 if params[:a16_junbok] != "true"
     a17 = 2 if params[:a17_gul] != "true"
     a18 = 2 if params[:a18_jogaeryu] != "true"
     a19 = 2 if params[:a19_gye] != "true"
     a20 = 2 if params[:a20_ohjingeoh] != "true"
     a21 = 2 if params[:a21_ahwangsan] != "true"
 
     #---------------------------------------------------------
    
 
     #--------------------search 에 맞게 메뉴 찾기---------------------
    
     @menus = Menu.where("#{:a1_maemil} <= ? AND #{:a2_mil} <= ? AND #{:a3_daedu} <= ? AND #{:a4_hodu} <= ? AND #{:a5_ddangkong} <= ? AND #{:a6_peach} <= ? AND #{:a7_tomato} <= ? AND #{:a8_piggogi} <= ? AND #{:a9_nanryu} <= ? AND #{:a10_milk} <= ? AND #{:a11_ddakgogi} <= ? AND #{:a12_shoigogi} <= ? AND #{:a13_saewoo} <= ? AND #{:a14_godeungeoh} <= ? AND #{:a15_honghap} <= ? AND #{:a16_junbok} <= ? AND #{:a17_gul} <= ? AND #{:a18_jogaeryu} <= ? AND #{:a19_gye} <= ? AND #{:a20_ohjingeoh} <= ? AND #{:a21_ahwangsan} <= ?", a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21)
     @menu_array = Kaminari.paginate_array(@menus).page(params[:page]).per(5)

     # -------------------메뉴(@menus)가 속한 식당 찾기.----------------
     
     @restaurants = Restaurant.where(:restaurant_name => @menus.map(&:restaurant_name).uniq)
     #  puts "실험씨작======================================================="
     @temp = Zizuminfo.where(:restaurant_name => @restaurants.map(&:restaurant_name))
     
     #default 값
     @temp = @temp.order(restaurant_name: :asc).order(zizum_name: :asc)
     
     if sido == "전체"
      @zizums = @temp
     elsif sigungu == "전체"
      @zizums = @temp.where("#{:sido} LIKE ?", sido)
     else
      @zizums = @temp.where("#{:sido} LIKE ? AND #{:sigungu} LIKE ?", sido, sigungu)
     end

     @zizum_array = Kaminari.paginate_array(@zizums).page(params[:page]).per(3)
     puts @zizums
     ### @menus.where(:shop_id => 어쩌고 ) 이용하기 (views 에서 보일 때)

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

    respond_to do |format|
      format.json {render json: $result}
    end
  end


  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)

 # -------------------메뉴추가시 알림----------------
    @restaurant = @menu.restaurant_id #메뉴의 레스토랑아이디
    @zizums = Zizuminfo.where(:restaurant_id => @restaurant) #해당레스토랑아이디를 가지는 지점들찾기
    @zizums_num =  Zizuminfo.where(:restaurant_id => @restaurant).count
    @rt_name = Restaurant.where(:id => @restaurant).pluck(:restaurant_name)

    # for n in 0...@zizums_num
    # #메뉴추가알림 메뉴는 restaurant랑 연동//좋아요는 zizuminfo랑연동//
    #   @zizums[n].followers.each do |follower| ##restaurant의 zizum 팔로워// 메뉴가 속한 식당을 찾고 그 지점을 찾기
    #     @new_alarm = NewAlarm.create! user: follower , #좋아요한 사용자
    #     content:"#{@rt_name}의 메뉴가 추가되었습니다.", # 워딩 수정하기 " #{@restuarant_name} #{@zizum_name}""
    #     link: request.referrer #수정하기 해당 article path로
    #   end
    # end
  

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update    
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end

 # -------------------메뉴(@menus)가 속한 식당 찾기.----------------
 @restaurant = @menu.restaurant_id #메뉴의 레스토랑아이디
 @zizums = Zizuminfo.where(:restaurant_id => @restaurant) #해당레스토랑아이디를 가지는 지점들찾기
 @zizums_num =  Zizuminfo.where(:restaurant_id => @restaurant).count
 @rt_name = Restaurant.where(:id => @restaurant).pluck(:restaurant_name)

#  for n in 0...@zizums_num
#    @zizums[n].followers.each do |follower|
#      @new_alarm = NewAlarm.create! user: follower , #좋아요한 사용자
#      content:"#{@rt_name}의 메뉴가 수정되었습니다.", # 워딩 수정하기 " #{@restuarant_name} #{@zizum_name}""
#      link: request.referrer 
#    end
#  end
end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    # Menumatch.where(menu: @menu.id)[0].destroy

    @restaurant = @menu.restaurant_id #메뉴의 레스토랑아이디
    @zizums = Zizuminfo.where(:restaurant_id => @restaurant) #해당레스토랑아이디를 가지는 지점들찾기
    @zizums_num =  Zizuminfo.where(:restaurant_id => @restaurant).count
    @rt_name = Restaurant.where(:id => @restaurant).pluck(:restaurant_name)
   
    # for n in 0...@zizums_num
    #   @zizums[n].followers.each do |follower| 
    #     @new_alarm = NewAlarm.create! user: follower , #좋아요한 사용자
    #     content:"#{@rt_name.to_s.gsub('["','').gsub('"]','')}의 메뉴 #{@menu.menu_name}이/가 삭제되었습니다.", # 워딩 수정하기 " #{@restuarant_name} #{@zizum_name}""
    #     link: request.referrer #수정하기 해당 article path로
    #   end
    # end
     

    respond_to do |format|
      format.html { redirect_to menus_url, notice: 'Menu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:menu_name,:a1_maemil,:a2_mil,:a3_daedu,:a4_hodu,:a5_ddangkong,:a6_peach,:a7_tomato,:a8_piggogi, :a9_nanryu, :a10_milk, :a11_ddakgogi, :a12_shoigogi, :a13_saewoo, :a14_godeungeoh, :a15_honghap, :a16_junbok, :a17_gul, :a18_jogaeryu, :a19_gye, :a20_ohjingeoh, :a21_ahwangsan, :restaurant_name, :restaurant_id, :image)
    end
  end