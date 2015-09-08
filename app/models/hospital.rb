class Hospital < ActiveRecord::Base
	has_many :albums
	has_many :reservations
	has_many :talks
end