class CreateFreeboards < ActiveRecord::Migration[5.2]
  def change
    create_table :freeboards do |t|
      t.string :title
      t.text :content
      t.string :name
      t.string :category
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
