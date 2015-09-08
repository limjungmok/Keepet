class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.boolean :r_check
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
