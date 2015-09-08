class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :t_content

      t.timestamps null: false
    end
  end
end
