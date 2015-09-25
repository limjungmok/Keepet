class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :r_title
      t.string :r_content

      t.timestamps null: false
    end
  end
end
