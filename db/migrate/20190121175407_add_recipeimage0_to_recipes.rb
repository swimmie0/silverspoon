class AddRecipeimage0ToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :recipeimage0, :string
  end
end
