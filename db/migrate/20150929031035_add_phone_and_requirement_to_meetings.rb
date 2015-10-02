class AddPhoneAndRequirementToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :phone, :string
    add_column :meetings, :requirement, :string
  end
end
