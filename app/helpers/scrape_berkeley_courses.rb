#!/usr/bin/env ruby

# Set your environment here.
#ENV["RAILS_ENV"] ||= 'development'
require File.expand_path("../../../config/environment", __FILE__)

require 'net/http'
require 'json'
require 'httparty'
require 'course'



#function that generates course, semester and coursem objects using the berkeley.edu API
def generate_all(debug = false)
	term = "SPRING" #Setting semesters
	termYear = Time.new.year #Searches for current year as default!
	file = File.open("departments.txt","rb") 
	lines = file.read.split("\n")
	file.close
	failed = 0
	succeeded = 0
	lines.each do |line|
		puts(line)
		if not line.include?(":")
			break
		end
		department = line.to_s.split(":")[1].strip
		url = "https://apis-qa.berkeley.edu/cxf/asws/classoffering?departmentCode=" << department.strip << "&term=" << term << 
		      "&termYear=" << termYear.to_s << "&_type=json&app_id=8865dfb5&app_key=125b30796efb2602f0ce00aaa0f6de5e"
	
		response = HTTParty.get(url)
		#puts("Response: " + response.body)
	
		parsed = JSON.parse(response.body)
		courses = parsed["ClassOffering"]
		#puts(course.to_s)
		courses.each do |course|
			begin
				name = course["courseTitle"]
				department = course["departmentCode"]
				course_number = course["courseNumber"].to_s
				units = course["lowerUnits"]
				#building = course["sections"][0]["sectionMeetings"]["building"]
				#room = course["sections"][0]["sectionMeetings"]["room"].to_s
				professor = course["sections"][0]["sectionMeetings"]["instructorNames"]

				coursem_info = {"units" => units}.to_s
				if debug
					puts("name: " + name)
					puts("department: " + department)
					puts("course_number: " + course_number)
					puts("units: " + units.to_s)
					#puts("building: " + building)
					#puts("room: " + room)
					puts("professor: " + professor)
					puts("coursem_info: " + coursem_info)
				end
				Course.new.createAll(name,coursem_info,department,course_number,term,termYear,professor)
				succeeded += 1
			rescue
				failed += 1
			end
		end
	
	end
	if debug
		puts("Number of failed course insertions: " + failed.to_s)
		puts("Number of course insertions that succeeded: " + succeeded.to_s)
	end
	
	
end

if __FILE__ == $0
	generate_all(true)
end
