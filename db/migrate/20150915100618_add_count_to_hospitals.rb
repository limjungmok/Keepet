class AddCountToHospitals < ActiveRecord::Migration
  def change
    add_column :hospitals, :count, :integer, default: 0
  end
end
