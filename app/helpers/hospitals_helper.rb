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
			review.created_at.strftime("%Y/%m/%d")
		end
	end
end
