class AddAvgGradeToHospitals < ActiveRecord::Migration
  def change
    add_column :hospitals, :avg_grade, :float
  end
end
