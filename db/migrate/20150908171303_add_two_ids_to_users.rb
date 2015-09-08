class AddTwoIdsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reservation_id, :integer
    add_column :users, :hospital_id, :integer
  end
end
