class HomeController < ApplicationController
  def index
    @popular_recipes = Recipe.order("created_at desc").limit(3);
  end
end
