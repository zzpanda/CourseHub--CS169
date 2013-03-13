require 'spec_helper'
require 'course'


describe Course do 
	it "Does not allow a course name with an empty string" do
		puts "Test 1: Course with course name that is an empty string doesn't get added"
		course = Course.new
		#course.TESTAPI_resetFixture
		course.addCourse("","course_info","department",123).should eq(-1)
	end

	it "Does not allow a course name that is not a string" do
		puts "\nTest 2: Course with course name not a string doesn't get added"
		course = Course.new
		course.addCourse(007, "course_info", "department", 123).should eq(-1)
	end

	it "Does not allow a course info with an empty string" do
		puts "\nTest 3: Course with course_info that is an empty string doesn't get added"
		course = Course.new
		course.addCourse("name", "", "department", 123).should eq(-2)
	end

	it "Does not allow a course info that is not a string" do
		puts "\nTest 4: Course with course_info that is not a string doesn't get added"
		course = Course.new
		course.addCourse("name",007, "department", 123).should eq(-2)
	end

	it "Does not allow a department with an empty string" do
		puts "\nTest 5: Course with department that is an empty string doesn't get added"
		course = Course.new
		course.addCourse("name", "course_info", "", 123).should eq(-3)
	end

	
	it "Does not allow a department that is not a string" do
		puts "\nTest 6: Course with department that is not a string doesn't get added"
		course = Course.new
		course.addCourse("name","course_info", 007, 123).should eq(-3)
	end

	it "Does not allow a course_number that is not an Integer" do
		puts "\nTest 7: Course with course_number that is not an Integer doesn't get added"
		course = Course.new
		course.addCourse("name", "course_info", "department", "007" ).should eq(-4)
	end

	
	it "Does allow a course with the right parameters get added" do
		puts "\nTest 8: Course with right parameters get added"
		course = Course.new
		course.addCourse("name", "course_info", "department", 007).should eq(1)
	end

	it "Does not allow a course already in the DB to get added" do
		puts "\nTest 9: Course already in DB doesn't get added"
		course = Course.new
		course.addCourse("name", "course_info", "department", 007)
		course.addCourse("name", "course_info", "department", 007).should eq(-5)
	end

	it "Does allow a deletion of a course in the DB" do
		puts "\nTest 10: Course in the DB can get deleted"
		course = Course.new
		course.addCourse("name", "course_info", "department", 007)
		course.deleteCourse("department", 007).should eq(1)
	end

	it "Does not allow a deletion of a course not in the DB" do
		puts "\nTest 11: Course not in the DB doesn't get deleted"
		course = Course.new
		course.deleteCourse("department", 007).should eq(-6)
	end


end
