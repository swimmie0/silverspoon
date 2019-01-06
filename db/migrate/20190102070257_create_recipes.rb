class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :explain
      t.text :content1
      t.string :recipeimage1
      t.text :content2
      t.string :recipeimage2
      t.text :content3
      t.string :recipeimage3
      t.text :content4
      t.string :recipeimage4
      t.text :content5
      t.string :recipeimage5
      t.text :content6
      t.string :recipeimage6
      t.text :content7
      t.string :recipeimage7
      t.text :content8
      t.string :recipeimage8
      t.text :content9
      t.string :recipeimage9
      t.text :content10
      t.string :recipeimage10

      t.timestamps
    end
  end
end
