class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :hospital
end
