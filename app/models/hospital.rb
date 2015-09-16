class Hospital < ActiveRecord::Base
	has_many :meetings

	validates :h_name, uniqueness: true
end