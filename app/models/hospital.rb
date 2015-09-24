class Hospital < ActiveRecord::Base
	has_many :meetings
	has_many :albums

	validates :h_name, uniqueness: true
end