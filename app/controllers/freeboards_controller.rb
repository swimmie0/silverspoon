class FreeboardsController < ApplicationController  
  before_action :set_freeboard, only: [:show, :edit, :update, :destroy]
  # 조회수
  impressionist actions: [:show]
  # GET /freeboards
  # GET /freeboards.json 
  
  def index
    # if user_signed_in? && current_user.name == nil
    #   flash[:warning] ='닉네임을 설정해주세요'
    #   redirect_to edit_user_registration_path
    # end
    # @free_daily = Freeboard.where(category: "일상글").order("created_at DESC")
    @free_daily=Freeboard.where(category: "일상글").order("created_at DESC")
    @free_information=Freeboard.where(category: "정보글").order("created_at DESC")
    @free_qna=Freeboard.where(category: "질문글").order("created_at DESC")
    # @free_adv=Kaminari.paginate_array(Freeboard.where(category: "홍보글").order("created_at DESC")).page(params[:page]).per(12)
    @free_crowd=Freeboard.where(category: "제보글").order("created_at DESC")
  
    # @recipe = Recipe.all
    
    @freeboards = if params[:search]
      @result = Freeboard.search(params[:search]).order("created_at DESC") 
      @freeboards = Kaminari.paginate_array(@result).page(params[:page]).per(12)
    elsif params[:category]
      @result = Freeboard.search(params[:category]).order("created_at DESC")
      @freeboards = Kaminari.paginate_array(@result).page(params[:page]).per(12)
    else  
      @result = Freeboard.all.order("created_at DESC")
      @freeboards = Kaminari.paginate_array(@result).page(params[:page]).per(12)      
    end

  end

  # GET /freeboards/1
  # GET /freeboards/1.json
  def show
    @freeboard = Freeboard.find(params[:id]) 
    @writer = @freeboard.user

    if params[:completed] == 'true'
      @freeboard.completed = true
    end

    @num = Freeboard.all.count
    
    if user_signed_in?
       @new_comment  = Comment.build_from(@freeboard, current_user.id, "") 
    end

    if @freeboard.locked && @writer != current_user 
      if !user_signed_in? || !current_user.admin?  
        flash.now[:warning] = '비밀글은 작성자와 관리자만 볼 수 있습니다.'
      # redirect_to freeboards_path
      end
    end

    # if @freeboard.user.profileimg.url == nil
    #   @freeboard.user.profileimg = 'defaultImg3.jpg'
    # end
  end

  def checkNum
    @free_all= Freeboard.all.count  
    @free_daily=Freeboard.where(category: "일상글").count
    @free_information=Freeboard.where(category: "정보글").count
    @free_qna=Freeboard.where(category: "질문글").count 
    @free_crowd=Freeboard.where(category: "제보글").count

    @category = params[:category]

    $result={"postNum" => nil}
    if @category == "일상글"
      $result["postNum"] =  @free_daily
    elsif @category == "정보글"
      $result["postNum"] =  @free_information
    elsif @category == "질문글"
      $result["postNum"] =  @free_qna
    elsif @category == "제보글"  
      $result["postNum"] =  @free_crowd 
    else
      $result["postNum"] = Freeboard.all.count               
    end
    
      $result = $result.to_json
      respond_to do |format|
        format.json {render json: $result}
      end
  end



  # GET /freeboards/new
  def new   
    # if user_signed_in? && current_user.name == nil
    #   flash[:warning] ='닉네임을 설정해주세요'
    #   redirect_to edit_user_registration_path
    # end
    @freeboard = Freeboard.new
  end

  # GET /freeboards/1/edit
  def edit
  end

  # POST /freeboards
  # POST /freeboards.json
  def create
    @freeboard = Freeboard.new(freeboard_params)
    @freeboard.user = current_user
    @freeboard.name = current_user.name

    respond_to do |format|
      if @freeboard.save
        format.html { redirect_to @freeboard, notice: 'Freeboard was successfully created.' }
        format.json { render :show, status: :created, location: @freeboard }
      else
        format.html { render :new }
        format.json { render json: @freeboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /freeboards/1
  # PATCH/PUT /freeboards/1.json
  def update
    respond_to do |format|
      if @freeboard.update(freeboard_params)
        format.html { redirect_to @freeboard, notice: 'Freeboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @freeboard }
      else
        format.html { render :edit }
        format.json { render json: @freeboard.errors, status: :unprocessable_entity }
      end
    end
    # @freeboard = Freeboard.find(params[:id]) 
    # if params[:completed] == 'true'
    #   @freeboard.completed = 'true'
    # end
  end

  # DELETE /freeboards/1
  # DELETE /freeboards/1.json
  def destroy
    @freeboard.destroy
    respond_to do |format|
      format.html { redirect_to freeboards_url }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_freeboard
      @freeboard = Freeboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def freeboard_params
      params.require(:freeboard).permit(:title, :content, :name, :category, :locked,:completed, :user_id)
    end
end
