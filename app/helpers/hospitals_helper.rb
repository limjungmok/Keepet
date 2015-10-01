module HospitalsHelper
	def timestamp_division(review)
		difference = Time.zone.now - review.created_at
		# 0 ~ 59초전
		if difference < 60
			"방금전"
		# 1분 ~ 60분전
		elsif difference > 60 && difference < 3600
			(difference/60).to_i.to_s + "분전"
		# 1시간 ~ 24시간
		elsif difference > 3600 && difference < 86400
			(difference/3600).to_i.to_s + "시간전"
		# 하루 전 ~ 과거
		else
			review.created_at.strftime("%y-%m-%d")
		end
	end


	def hospital_score(hospital)
		@hospital = Hospital.find(params[:id])
		#@meetings = Meeting.all
		@meetings = @hospital.meetings.all

		@reviews = @hospital.reviews.all
		
		@hospital.avg_grade = 0
		
		@reviews.each do|review|	
			@hospital.avg_grade += review.grade
		end

		if @reviews.count == 0
			@hospital.avg_grade = 0
		else
			@hospital.avg_grade = (@hospital.avg_grade / @reviews.count)
		end
	end
end
