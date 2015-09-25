class AddHospitalIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :hospital_id, :integer
  end
end
