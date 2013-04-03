require 'spec_helper'
require 'semester'


describe Semester do 
	it "Does not allow a semester term with an empty string" do
		puts "Test 1: Semester with term name as empty string is not valid"
		Semester.checkSemester("",2013).should eq(-5)
	end

	it "Does not allow a semester term that is not a string" do
		puts "\nTest 2: Semester with term name that is not a string is not valid"
		Semester.checkSemester(007,2013).should eq(-5)
	end

	it "Does not allow a semester term with the wrong string input(check semester.rb for right values)" do
		puts "\nTest 3: Semester with invalid string term name is not valid"
		Semester.checkSemester("falls",2013).should eq(-5)
	end

	it "Does not allow a semester with invalid year that's not an integer get added" do
		puts "\nTest 4: Semester with year not an integer is not valid"
		Semester.checkSemester("fall","007").should eq(-6)
	end

	it "Does not allow a semester with year less than the min get added(check semester.rb for year_min" do
		puts "\nTest 5: Semester with year less than minimum is not valid"
		Semester.checkSemester("fall",1989).should eq(-6)
	end

	it "Does not allow a semester with year more than the max get added(check semester.rb for year_max" do
		puts "\nTest 6: Semester with year more than the max is not valid"
		Semester.checkSemester("fall",Time.new.year + 2).should eq(-6)
	end

	it "Does allow a semester with right values get added" do
		puts "\nTest 7: Semester with right values is not valid"
    @course = Course.new
    @course.createAll("Computer Science","Blabla","CS","169","SPRING", 2013, "GEORGE")
		Semester.checkSemester("SPRING",2013).class.should eq(Semester)
	end

	it "Does not allow a semester already in the DB to get added" do
		puts "\nTest8: Semester already in DB is not valid"
		Semester.checkSemester("fall",Time.new.year).should eq(-7)
	end

	it "Does allow a semester in the DB get destroyed" do
		puts "\nTest9: Semester in the DB can be destroyed"
		@course = Course.new
    @course.createAll("computer science","blabla","CS","169","Spring", 2013, "George")
    @semester = Semester.first
		@semester.destroySemester(@semester.id).should eq(1)
  end

  it "should destroy the coursem corresponding to the semester" do
    @course = Course.new
    @course.createAll("computer science","blabla","CS","169","Spring", 2013, "George")
    @course.createAll("computer science","blabla","CS","169","Fall", 2012, "A")
    @course.createAll("computer science","blabla","CS","170","Fall", 2012, "B")
    @semester = Semester.first
    @semester.destroy
    Semester.all.length.should eq(1)
  end

	it "Does not allow a semester not in the DB to be destroyed" do
		puts "\nTest10: Semester not in the DB should not be destroyed"
		@semester = Semester.new
		@semester.destroySemester(@semester.id).should eq(-21)
	end
	
	

end
