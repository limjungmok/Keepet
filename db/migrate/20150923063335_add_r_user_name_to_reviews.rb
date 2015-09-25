class AddRUserNameToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :r_user_name, :string
  end
end
