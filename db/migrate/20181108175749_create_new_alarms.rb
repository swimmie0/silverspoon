class CreateNewAlarms < ActiveRecord::Migration[5.2]
  def change
    create_table :new_alarms do |t|
      t.string :content
      t.belongs_to :user
      t.string :link

      t.timestamps
    end
  end
end
