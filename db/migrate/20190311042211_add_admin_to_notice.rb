class AddAdminToNotice < ActiveRecord::Migration[5.2]
  def change
    add_reference :notices, :user, foreign_key: true
  end
end
