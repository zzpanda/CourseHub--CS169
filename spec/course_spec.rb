require 'spec_helper'
require 'course'

describe Course do 
	it "Does not allow a course with a blank name" do
		puts "Test 1"
		course = Course.new
		Course.addCourse(" ", "course_info", "department", 123).should eq(-1)
		
	end

end
