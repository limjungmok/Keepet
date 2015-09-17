require 'nokogiri'
require 'open-uri'
require 'json'
require 'net/http'
require 'httparty'

class HospitalsController < ApplicationController

	def new
		service_key_gangnam = "70554f5a78636e643739784d584f62"
		
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
		@is_reservation = 0
	end

	def index
		@hospitals = Hospital.all

		#총 동물병원 수 = @hospital_count
		@hospital_count = 0
		@hospitals.each do |h|
			@hospital_count = @hospital_count + 1;
	    end
		service_key_gangnam = "70554f5a78636e643739784d584f62"

	    get_json(service_key_gangnam)
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
		search_location = "gangnam"
		#서비스키
		service_key = get_service_key
		#병원이 속한 시/구
		location_hospital = "Gn"
		#기본 URL
		base_url = "http://openapi."+search_location+
					".go.kr:8088/"+service_key+type+location_hospital+
					"AnimalHospital/1/1000"
		#JSON객체를 받음
	    @response = HTTParty.get(base_url)
	    #객체를 쪼갠다.몸통 -> GnAnimalHospital 객체 -> row 배열
	    @hospital = JSON.parse(@response.body)["GnAnimalHospital"]["row"]

	    #배열을 전부 돌린다. 동시에 DB에 저장해준다.
	    #돌릴때, 반환되는 주소를 가지고 x,y값을 찾도록 한다.
	    @a = []

	    @hospital.each do |h|
	    	hospital = Hospital.new(:h_name => h["WRKP_NM"], :h_address => h["SITE_ADDR"], :h_phone => h["SITE_TEL"])

	    	get_json_location(hospital.h_address)
	    	
	    	@hospital_location.each do |loc|

	    		if((@userquery.to_s).in? hospital.h_address)
		    		hospital.h_latitude = loc["point"]["y"]	    		
		    		hospital.h_lontitude = loc["point"]["x"]
		    		hospital.save
	    		end
	    	end
	    	if hospital.h_phone == ""
	    		hospital.h_phone = "없음"
	    	end
	    	if hospital.h_latitude.nil?
	    		hospital.h_latitude = 0
	    	end
	    	if hospital.h_lontitude.nil?
	    		hospital.h_lontitude = 0
	    	end
	    	
	    	b = [hospital.h_name, hospital.h_address, hospital.h_phone, hospital.h_latitude, hospital.h_lontitude]
	    	@a.push b

	    	hospital.save
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












