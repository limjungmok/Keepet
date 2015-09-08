class AddXYToHospitals < ActiveRecord::Migration
  def change
    add_column :hospitals, :h_latitude, :float
    add_column :hospitals, :h_lontitude, :float
  end
end
