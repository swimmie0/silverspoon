class HomeController < ApplicationController
  def index
    @popular_recipes = Recipe.order("created_at desc").limit(3);
    @recent_res = Freeboard.where(category: "정보글").order("created_at desc").limit(5);
    @recent_daily = Freeboard.where(category: "일상글").order("created_at desc").limit(5);
   
  end
end
