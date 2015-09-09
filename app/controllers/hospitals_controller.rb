require 'nokogiri'
require 'open-uri'
require 'json'
require 'net/http'
require 'httparty'

class HospitalsController < ApplicationController


	def new
	end

	def create
	end

	def show
		type="/json/"
		search_location = "gangnam"
		service_key = "70554f5a78636e643739784d584f62"
		location_hospital = "Gn"

		base_url = "http://openapi."+search_location+
					".go.kr:8088/"+service_key+type+location_hospital+
					"AnimalHospital/1/1000"
		#http://openapi.gangnam.go.kr:8088/70554f5a78636e643739784d584f62/json/GnAnimalHospital/1/1000
	    
	    @response = HTTParty.get(base_url)
	    @http_party_json = JSON.parse(@response.body)["GnAnimalHospital"]["row"]
	    @h_name = @http_party_json.length
	end

	def index
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def get_json
	end
end












