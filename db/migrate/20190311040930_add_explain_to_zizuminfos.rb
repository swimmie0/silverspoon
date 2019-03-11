class AddExplainToZizuminfos < ActiveRecord::Migration[5.2]
  def change
    add_column :zizuminfos, :explain, :string
  end
end
