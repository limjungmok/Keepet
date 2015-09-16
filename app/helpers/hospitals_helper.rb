module HospitalsHelper
	def up_count
		@test = Hospital.find(1)
		@test.count = @test.count + 1
		@test.save
		if (@test.count > Hospital.count)
			@test.count = 1
			@test.save
		end
	end

end
