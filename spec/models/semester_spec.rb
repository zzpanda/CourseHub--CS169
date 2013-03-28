require 'spec_helper'
require 'semester'


describe Semester do 
	it "Does not allow a semester term with an empty string" do
		puts "Test 1: Semester with term name as empty string doesn't get added"
		semester = Semester.new
		semester.createSemesters("",2013).should eq(-1)
	end

	it "Does not allow a semester term that is not a string" do
		puts "\nTest 2: Semester with term name that is not a string doesn't get added"
		semester = Semester.new
		semester.createSemesters(007,2013).should eq(-1)
	end

	it "Does not allow a semester term with the wrong string input(check semester.rb for right values)" do
		puts "\nTest 3: Semester with invalid string term name doesn't get added"
		semester = Semester.new
		semester.createSemesters("falls",2013).should eq(-1)
	end

	it "Does not allow a semester with invalid year that's not an integer get added" do
		puts "\nTest 4: Semester with year not an integer doesn't get added"
		semester = Semester.new
		semester.createSemesters("fall","007").should eq(-2)
	end

	it "Does not allow a semester with year less than the min get added(check semester.rb for year_min" do
		puts "\nTest 5: Semester with year less than minimum doesn't get added"
		semester = Semester.new
		semester.createSemesters("fall",1989).should eq(-2)
	end

	it "Does not allow a semester with year more than the max get added(check semester.rb for year_max" do
		puts "\nTest 6: Semester with year more than the max doesn't get added"
		semester = Semester.new
		semester.createSemesters("fall",Time.new.year + 2).should eq(-2)
	end

	it "Does allow a semester with right values get added" do
		puts "\nTest 7: Semester with right values gets added"
		semester = Semester.new
		semester.createSemesters("fall",Time.new.year).should eq(1)
	end

	it "Does not allow a semester already in the DB to get added" do
		puts "\nTest8: Semester already in DB shouldn't get added"
		semester = Semester.new
		semester.createSemesters("fall",Time.new.year)
		semester.createSemesters("fall",Time.new.year).should eq(-3)
	end

	it "Does allow a semester in the DB get deleted" do
		puts "\nTest9: Semester in the DB can be deleted"
		semester = Semester.new
		semester.createSemesters("fall",Time.new.year)
		semester.removeSemester("fall", Time.new.year).should eq(1)

	end

	it "Does not allow a semester not in the DB to be deleted" do
		puts "\nTest10: Semester not in the DB should not be deleted"
		semester = Semester.new
		semester.removeSemester("fall", Time.new.year).should eq(-4)
	end
	
	

end
