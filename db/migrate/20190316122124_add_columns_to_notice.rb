class AddColumnsToNotice < ActiveRecord::Migration[5.2]
  def change
    add_column :notices, :image, :string
    add_column :notices, :isModal, :boolean
  end
end
