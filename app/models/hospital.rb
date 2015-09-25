class Hospital < ActiveRecord::Base
	has_many :meetings
	has_many :reviews
	has_many :users, :through => :reviews

	validates :h_name, uniqueness: true
end