class StaticPagesController < ApplicationController
  
	def home
		
	end
	def help
		service_key_gangnam = "70554f5a78636e643739784d584f62"
		
		#동물병원 API
		get_json(service_key_gangnam)
		#동물병원 주소 -> x,y API
		#get_json_location(nhn_service_key)
	end
		

end
