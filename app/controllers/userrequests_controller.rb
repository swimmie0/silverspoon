class UserrequestsController < ApplicationController  
  def index
    @add_requests = Userrequest.where(request_type: "추가", status: "미처리")
    @edit_requests = Userrequest.where(request_type: "수정", status: "미처리")
    @delete_requests = Userrequest.where(request_type: "삭제", status: "미처리")
  end

  def new_request
    @r_id = params[:restaurantID]

    #알레르기 정보 -1로 세팅 후 로딩
    @userrequest = Userrequest.new(a1_maemil: -1, a2_mil: -1,a3_daedu: -1,a4_hodu: -1, a5_ddangkong: -1, a6_peach: -1, a7_tomato: -1, a8_piggogi: -1, a9_nanryu: -1, a10_milk:-1, a11_ddakgogi: -1, a12_shoigogi: -1, a13_saewoo: -1, a14_godeungeoh: -1, a15_honghap: -1, a16_junbok: -1, a17_gul: -1, a18_jogaeryu: -1, a19_gye: -1, a20_ohjingeoh: -1, a21_ahwangsan: -1)
  end

  def edit_request
    @m_id = params[:menuID]
    @original_info = Menu.find(@m_id)
    
    #기존 해당 메뉴의 값을 로드
    @userrequest = Userrequest.new(menu_name: @original_info.menu_name, restaurant_id: @original_info.restaurant_id, restaurant_name: @original_info.restaurant_name, a1_maemil: @original_info.a1_maemil, a2_mil: @original_info.a2_mil,a3_daedu: @original_info.a3_daedu,a4_hodu: @original_info.a4_hodu, a5_ddangkong: @original_info.a5_ddangkong, a6_peach: @original_info.a6_peach, a7_tomato: @original_info.a7_tomato, a8_piggogi: @original_info.a8_piggogi, a9_nanryu: @original_info.a9_nanryu, a10_milk: @original_info.a10_milk, a11_ddakgogi: @original_info.a11_ddakgogi, a12_shoigogi: @original_info.a12_shoigogi, a13_saewoo: @original_info.a13_saewoo, a14_godeungeoh: @original_info.a14_godeungeoh, a15_honghap: @original_info.a15_honghap, a16_junbok: @original_info.a16_junbok, a17_gul: @original_info.a17_gul, a18_jogaeryu: @original_info.a18_jogaeryu, a19_gye: @original_info.a19_gye, a20_ohjingeoh: @original_info.a20_ohjingeoh, a21_ahwangsan: @original_info.a21_ahwangsan, image: @original_info.image)

  end

  def create
    @userrequest = Userrequest.new(userrequest_params)
    @userrequest.save
    redirect_to(profile_path(current_user.id))
  end

  def permit
    #추가 / 수정 승인처리
    if params[:commit] == "추가 승인" || params[:commit] == "수정 승인" 
        #신청 로그에 처리상태 변경
        params[:permit_ids].each do |p|
          @request_log = Userrequest.find(p)
          @request_log.status = "승인"
          @request_log.save

          #수정
          @target_menu = Menu.where(restaurant_name: @request_log.restaurant_name, menu_name: @request_log.menu_name)[0]

          #추가
          if @target_menu.nil?
            @target_menu = Menu.new
          end       

          @target_menu.a1_maemil = @request_log.a1_maemil
          @target_menu.a2_mil = @request_log.a2_mil
          @target_menu.a3_daedu = @request_log.a3_daedu
          @target_menu.a4_hodu = @request_log.a4_hodu
          @target_menu.a5_ddangkong = @request_log.a5_ddangkong
          @target_menu.a6_peach = @request_log.a6_peach
          @target_menu.a7_tomato = @request_log.a7_tomato
          @target_menu.a8_piggogi = @request_log.a8_piggogi
          @target_menu.a9_nanryu = @request_log.a9_nanryu
          @target_menu.a10_milk = @request_log.a10_milk
          @target_menu.a11_ddakgogi = @request_log.a11_ddakgogi
          @target_menu.a12_shoigogi = @request_log.a12_shoigogi
          @target_menu.a13_saewoo = @request_log.a13_saewoo
          @target_menu.a14_godeungeoh = @request_log.a14_godeungeoh
          @target_menu.a15_honghap = @request_log.a15_honghap
          @target_menu.a16_junbok = @request_log.a16_junbok
          @target_menu.a17_gul = @request_log.a17_gul
          @target_menu.a18_jogaeryu = @request_log.a18_jogaeryu
          @target_menu.a19_gye = @request_log.a19_gye
          @target_menu.a20_ohjingeoh = @request_log.a20_ohjingeoh
          @target_menu.a21_ahwangsan = @request_log.a21_ahwangsan
          @target_menu.save
        end
    #삭제 승인처리
    elsif params[:commit] == "삭제 승인" 
        params[:permit_ids].each do |p|
          @request_log = Userrequest.find(p)

          #신청 로그 처리상태 변경
          @request_log.status = "승인"
          @request_log.save

          #메뉴 삭제 실행
          @target_menu = Menu.where(restaurant_name: @request_log.restaurant_name, menu_name: @request_log.menu_name)[0]
          @target_menu.destroy
        end  
    #반려처리
    else
      params[:permit_ids].each do |p|
        @request_log = Userrequest.find(p)

        @request_log.status = "반려처리"
        @request_log.save
      end
    end
    redirect_to "/userrequests"
  end

  
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def userrequest_params
    params.require(:userrequest).permit(:request_type, :uid, :status, :restaurant_id, :restaurant_name,:menu_name, :a1_maemil,:a2_mil,:a3_daedu,:a4_hodu,:a5_ddangkong,:a6_peach,:a7_tomato,:a8_piggogi, :a9_nanryu, :a10_milk, :a11_ddakgogi, :a12_shoigogi, :a13_saewoo, :a14_godeungeoh, :a15_honghap, :a16_junbok, :a17_gul, :a18_jogaeryu, :a19_gye, :a20_ohjingeoh, :a21_ahwangsan, :image, permit_ids: [])
  end
end