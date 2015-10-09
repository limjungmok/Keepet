class StaticPagesController < ApplicationController	
	def home
		@hospital_1 = Hospital.find(1)
		@hospital_2 = Hospital.find(3)
		@hospital_3 = Hospital.find(4)
		@hospital_4 = Hospital.find(5)
		@hospital_5 = Hospital.find(6)
		@hospital_6 = Hospital.find(7)
		@hospital_7 = Hospital.find(8)
		@hospital_8 = Hospital.find(9)
	end
end
