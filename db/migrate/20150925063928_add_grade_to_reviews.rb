class AddGradeToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :grade, :float
  end
end
