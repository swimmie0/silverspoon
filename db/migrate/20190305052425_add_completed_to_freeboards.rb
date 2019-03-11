class AddCompletedToFreeboards < ActiveRecord::Migration[5.2]
  def change
    add_column :freeboards, :completed, :boolean, default: false
  end
end
