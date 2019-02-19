class RestaurantsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  
  # 식당으로 검색
  def serach
  end

  def index
   @restaurants = Restaurant.all
   @current_restaurants = Restaurant.order("created_at desc").limit(9);
   @zizuminfos = Zizuminfo.all.order("created_at DESC");
   @tot_zizums = Kaminari.paginate_array(@zizuminfos).page(params[:page]).per(9)
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant_name = @restaurant.restaurant_name
      ## for notification
      # Board.create!(content: "새로운 식당 #{@restaurant_name}가 등록되었습니다.") # 워딩 수정하기
      # link: request.referrer #수정하기 해당 article path로
  

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def crawling 
    Restaurant.RestaurantName
    puts "\n\nrestaurant name finished\n\n"
    # sleep 1.5
    Zizuminfo.Subway        #1
    # Zizuminfo.Momstouch     #2
    # # Zizuminfo.Raracost
    # Zizuminfo.Vips          #3
    # Zizuminfo.Coffeebean    #4
    # Zizuminfo.Popeyes       #5
    # Zizuminfo.Baskin        #6
    # Zizuminfo.PizzaSchool   #7
    Zizuminfo.SeasonsTable  #8
    # Zizuminfo.Burgerking    #9
    # Zizuminfo.DunkinDonuts  #10   
    # ### SushiHiroba         #11
    puts "\n\nzizuminfo finished\n\n"
    Menu.Subway             #1
    # Menu.Momstouch          #2
    # Menu.Vips               #3
    # # Menu.Raracost
    # Menu.Coffeebean         #4
    # Menu.Popeyes            #5
    # Menu.Baskin             #6
    # Menu.PizzaSchool        #7
    Menu.SeasonsTable       #8
    # Menu.Burgerking         #9
    # Menu.DunkinDonuts       #10
    # ### SushiHiroba         #11    
    puts "crwaling update finished!"
    #redirect_to userrequests_path
    redirect_to home_index_path

    @successCrawl = 1
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:restaurant_id, :restaurant_name, :a1_maemil,:a2_mil,:a3_daedu,:a4_hodu,:a5_ddangkong,:a6_peach,:a7_tomato,:a8_piggogi, :a9_nanryu, :a10_milk, :a11_ddakgogi, :a12_shoigogi, :a13_saewoo, :a14_godeungeoh, :a15_honghap, :a16_junbok, :a17_gul, :a18_jogaeryu, :a19_gye, :a20_ohjingeoh, :a21_ahwangsan, :image)
    end
end
