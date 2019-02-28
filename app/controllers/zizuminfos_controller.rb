class ZizuminfosController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_zizuminfo, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, except: [:index, :show, :getGungu, :getZizum]
  helper_method :value2icon

  # GET /zizuminfos
  # GET /zizuminfos.json

  def search
  end
  
  def getZizum
    key = params[:keyvalue]
    @zizums = Zizuminfo.all.where("#{:zizum_name} LIKE ?", "%#{key}%").map(&:zizum_name)[0]
    puts @zizums
    # @restaurant = Restaurant.select("restaurant_name").all

  end
  
  def index
    sido = params[:sido]
    sigungu = params[:sigungu]
    if params[:restaurant_name] == ""
      @temp = Zizuminfo.all
    else 
      @temp = Zizuminfo.where("#{:restaurant_name} LIKE ?", params[:restaurant_name])
    end
      @restaurants = Restaurant.where("#{:restaurant_name} LIKE?", params[:restaurant_name])
    
    
    if sido == "전체"
      @zizums = @temp
     elsif sigungu == "전체"
      @zizums = @temp.where("#{:sido} LIKE?", sido)
     else
      @zizums = @temp.where("#{:sido} LIKE ? AND #{:sigungu} LIKE ?", sido, sigungu)
    end
    
    # @zizums = @zizums[0]
  end

  def getGungu
    #받아오기
    @locations = JSON.parse(File.read(File.join('sigungu.json')))

    @sido_name = params[:sido]
    @sigungu_name = @locations["data"][0][@sido_name]

    $result={"sido_name" => nil, "sigungu_name"=>nil}
    $result["sido_name"]= @sido_name
    $result["sigungu_name"]= @sigungu_name
    
    $result = $result.to_json

    respond_to do |format|
      format.json {render json: $result}
    end

  end

  # GET /zizuminfos/1
  # GET /zizuminfos/1.json
  def show
    @allergy_tags=["난류","우유","복숭아","토마토","메밀","밀","대두(콩)","닭고기","쇠고기","돼지고기","새우","고등어","홍합","전복","굴","조개류","게","오징어","호두","땅콩","아황산류"]
    
    @res_id = params[:res_id]

    @res = Restaurant.where(:id => @res_id)
    puts "=++++++show++++++++++++++++"
  
    @zizum_menus = Menu.where(:restaurant_name => @res.map(&:restaurant_name))
    puts @zizum_menus[0]
    @menus = @zizum_menus.paginate(page: params[:page], per_page: 10)
  end

  def zizummenus
    
  end

  # GET /zizuminfos/new
  def new
    @zizuminfo = Zizuminfo.new
  end

  # GET /zizuminfos/1/edit
  def edit
  end

  # POST /zizuminfos
  # POST /zizuminfos.json
  def create
    @zizuminfo = Zizuminfo.new(zizuminfo_params)
    
    respond_to do |format|
      if @zizuminfo.save
        format.html { redirect_to @zizuminfo, notice: 'Zizuminfo was successfully created.' }
        format.json { render :show, status: :created, location: @zizuminfo }
      else
        format.html { render :new }
        format.json { render json: @zizuminfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zizuminfos/1
  # PATCH/PUT /zizuminfos/1.json
  def update
    respond_to do |format|
      if @zizuminfo.update(zizuminfo_params)
        format.html { redirect_to @zizuminfo, notice: 'Zizuminfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @zizuminfo }
      else
        format.html { render :edit }
        format.json { render json: @zizuminfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zizuminfos/1
  # DELETE /zizuminfos/1.json
  def destroy
    @zizuminfo.destroy
    respond_to do |format|
      format.html { redirect_to zizuminfos_url, notice: 'Zizuminfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  #숫자 표기 변환 method
  def value2icon(value)
    #교차 위험
    if value == -2
      return '<span class="allergy-i allergy-star">△</span>'.html_safe
    #제공 안함
    elsif value == -1
      return '<span class="allergy-i allergy-null">·</span>'.html_safe
    #없음
    elsif value == 0
      return '<i class="fas fa-times allergy-i allergy-none"></i>'.html_safe
    #있음
    else
      return '<i class="far fa-circle allergy-i allergy-circle"></i>'.html_safe
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zizuminfo
      @zizuminfo = Zizuminfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zizuminfo_params
      params.require(:zizuminfo).permit(:zizum_name, :sido, :sigungu, :sangse_juso, :phone_number, :image, :restaurant)
    end
end
