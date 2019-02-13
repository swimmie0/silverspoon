class HomeController < ApplicationController
  def index
    @popular_recipes = Recipe.order("created_at desc").limit(3);
    @recent_res = Freeboard.where(category: "정보글").order("created_at desc").limit(25);
    @recent_adv = Freeboard.where(category: "홍보글").order("created_at desc").limit(25);
    
    @res_length = @recent_res.length()
    @adv_length = @recent_adv.length()
  end
end
