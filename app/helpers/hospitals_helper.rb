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
  def meetings_ajax_previous_link
    ->(param, date_range) { link_to raw("<<"), {param => date_range.first - 1.day}, remote: :true}
  end

  def meetings_ajax_next_link
    ->(param, date_range) { link_to raw(">>"), {param => date_range.last + 1.day}, remote: :true}
  end
end
