class AddExplainToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :explain, :string
  end
end
