require 'nokogiri'
require 'open-uri'
require 'json'
require 'net/http'
require 'httparty'

class HospitalsController < ApplicationController

	def new
		service_key_gangnam = "70554f5a78636e643739784d584f62"
		service_key_gwangjin = "67796c6966636e643131355659425258"
		#동물병원 API
		get_json(service_key_gangnam)
		#동물병원 주소 -> x,y API
		#get_json_location(nhn_service_key)
	end

	def map
		
	end

	def create
	end

	def show
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

	def index
	  @hospitals = Hospital.all
	  @hospitals.each do |hospital|
	     @reviews = hospital.reviews.all
	     
	     hospital.avg_grade = 0
	     hospital.save
	     @reviews.each do|review|   
	        hospital.avg_grade += review.grade
	        hospital.save
	     end

	     if @reviews.count == 0
	        hospital.avg_grade = 0
	        hospital.save
	     else
	        hospital.avg_grade = (hospital.avg_grade / @reviews.count)
	        hospital.save
	     end
	  end
	  
	  #총 동물병원 수 = @hospital_count
	  @hospital_count = 0
	  @hospitals.each do |h|
	     @hospital_count = @hospital_count + 1;
	   end


	  #동물병원 정보를 @hospitals_array 배열에 모두 넣는 구간
	  @hospitals_array = []
	  @hospitals.each do |hospital|
	     if hospital.h_phone == ""
	         hospital.h_phone = " "
	      end

	      #폐업한 동물병원 xy 0으로 만들기
	      if hospital.h_latitude.nil?
	         hospital.h_latitude = 0
	      end
	      if hospital.h_lontitude.nil?
	         hospital.h_lontitude = 0
	      end

	      #동물병원 상세 주소 수정
	      real_hospital_address = hospital.h_address.gsub("서울특별시","").gsub("1","").gsub("2","").gsub("3","").gsub("4","").gsub("5","").gsub("6","").gsub("7","").gsub("8","").gsub("9","").gsub("0","").gsub("번지","").gsub("호","").gsub("층","").gsub("지하","").gsub("아카데미스위트 A동","").gsub("외 필지","").gsub("오성빌딩","").gsub("지상, 일부","").gsub("강남힐스테이트에코","").gsub(",","").gsub("덕산빌딩","").gsub("-","").gsub("지상","").gsub("일부","").gsub("강남리더스프라자","").gsub("풍림아이원레몬","")
	      hospital.h_address = real_hospital_address

	      #동물병원 이름 공백 없애기   ->   .gsub(/\s+/, ""
	     array = [hospital.h_name.gsub(/\s+/,""), hospital.h_address, hospital.h_phone, hospital.h_latitude, hospital.h_lontitude]
	     @hospitals_array.push array
	  end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def get_json(get_service_key)
		#JSON  타입
		type="/json/"
		#찾으려는 위치
		#search_location = "gwangjin"
		search_location = "gwangjin"

		#서비스키
		service_key = get_service_key
		#병원이 속한 시/구
		#location_hospital = "Gwangjin"
		location_hospital="Gwangjin"
		#기본 URL
		base_url = "http://openapi."+search_location+
					".go.kr:8088/"+service_key+type+location_hospital+
					"AnimalHospital/1/1000"
		#JSON객체를 받음
	    @response = HTTParty.get(base_url)
	    #객체를 쪼갠다.몸통 -> GnAnimalHospital 객체 -> row 배열
	    @hospital = JSON.parse(@response.body)["GwangjinAnimalHospital"]["row"]

	    #배열을 전부 돌린다. 동시에 DB에 저장해준다.
	    #돌릴때, 반환되는 주소를 가지고 x,y값을 찾도록 한다.

	    @hospital.each do |h|
	    	if(h["TRD_STATE_GBN_CTN"] == "정상")
		    	hospital = Hospital.new(:h_name => h["WRKP_NM"].gsub(/\s+/, ""), :h_address => h["SITE_ADDR"], :h_phone => h["SITE_TEL"])

		    	get_json_location(hospital.h_address)
		    	
		    	@hospital_location.each do |loc|

		    		if((@userquery.to_s).in? hospital.h_address)
			    		hospital.h_latitude = loc["point"]["y"]	    		
			    		hospital.h_lontitude = loc["point"]["x"]
			    		hospital.save
		    		end
		    	end
		    	
		    	#동물병원 hover id 값을 위한 빈칸 지우는 코드 
		    	hospital.h_name.gsub(/\s+/,"")	

		    	hospital.save
	    	else

	    	end
	    end
	end

	def get_json_location(location)
		base_url = "http://openapi.map.naver.com/api/geocode?key=7abf142941432839aa8e17eeef6181b7&encoding=utf-8&coord=latlng&output=json&query="+location
		
		safeurl = URI.encode(base_url.strip)

		@response_location = HTTParty.get(safeurl)
	    @hospital_location = JSON.parse(@response_location.body)["result"]["items"] unless JSON.parse(@response_location.body)["result"].nil?
	    @userquery = JSON.parse(@response_location.body)["result"]["userquery"] unless JSON.parse(@response_location.body)["result"].nil?
	end
end

