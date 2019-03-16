class HomeController < ApplicationController
  def index
    @popular_recipes = Recipe.order("created_at desc").limit(3);
    @recent_res = Freeboard.where(category: "정보글").order("created_at desc").limit(5);
    @recent_daily = Freeboard.where(category: "일상글").order("created_at desc").limit(5);
   
    #  notice에 팝업등록 column추가
    # 팝업등록 true인거 하나찾아서 팝업등록
    #  이미지도 띄울수 있게?해야겠지..?
    # @weeksago = Date.today.weeks_ago(1) #일주일간
    # @now =Date.today
    @popNotice = Notice.find_by(isModal: true)
  end
end
