class RenameExplainationToExplanation < ActiveRecord::Migration[5.2]
  def change
    rename_column :recipes, :explaination, :explanation
  end
end
