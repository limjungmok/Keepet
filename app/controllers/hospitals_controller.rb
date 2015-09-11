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
		@hospital = Hospital.all
	end

	def create
	end

	def show
	end

	def index
	end

	def edit
	end

	def update
	end

	def destroy
	end


	def get_json(get_service_key)
		nhn_service_key = "7abf142941432839aa8e17eeef6181b7"
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

	    @hospital.each do |h|
	    	hospital = Hospital.new(:h_name => h["WRKP_NM"], :h_address => h["SITE_ADDR"], :h_phone => h["SITE_TEL"])

	    	get_json_location(nhn_service_key)
	    	@hospital_location.each do |loc|
	    		if(loc["address"] == hospital.h_address)
	    		hospital.h_latitude = loc["point"]["y"]
	    		hospital.h_lontitude = loc["point"]["x"]
	    		end
	    	end

	    	hospital.save
	    end
	end

	def get_json_location(get_service_key)
		service_key = get_service_key
		base_url = "http://openapi.map.naver.com/api/geocode?key="+service_key+"&encoding=utf-8&coord=latlng&output=json&query=%EC%84%9C%EC%9A%B8%ED%8A%B9%EB%B3%84%EC%8B%9C%20%EA%B0%95%EB%82%A8%EA%B5%AC%20%EC%8B%A0%EC%82%AC%EB%8F%99%20587%EB%B2%88%EC%A7%80%2013%ED%98%B8%20%EC%A7%80%ED%95%98%201%EC%B8%B5"
		
		@response_location = HTTParty.get(base_url)
	    @hospital_location = JSON.parse(@response_location.body)["result"]["items"]
	end
end












