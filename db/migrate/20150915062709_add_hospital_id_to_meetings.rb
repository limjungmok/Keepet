class AddHospitalIdToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :hospital_id, :integer
  end
end
