class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :h_name
      t.string :h_phone
      t.string :h_address
      t.integer :h_small
      t.integer :h_big
      t.boolean :h_contract
      t.boolean :h_walking
      t.string :h_time
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
