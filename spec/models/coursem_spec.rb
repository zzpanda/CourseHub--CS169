require 'spec_helper'
require 'coursem'

describe Coursem do
  it "should create the correct coursem in database" do
    Coursem.createCourseSemesters("George", 2, 3, "blabla")
    @coursem = Coursem.find_by_course_id_and_semester_id(2, 3)
    @coursem.professor.should eq("George")
    @coursem = Coursem.find_by_course_id_and_semester_id(3, 5)
    @coursem.should eq(nil)
  end

  it "should get correct course information" do
    @course = Course.new
    @course.createAll("computer science","blabla","CS","169","Spring", 2013, "George")
    @course.createAll("computer science","blabla","CS","169","Fall", 2012, "A")
    @course.createAll("computer science","blabla","CS","170","Fall", 2012, "B")
    @coursem = Coursem.getCoursemInformation(1)
    @coursem[:users].should eq([])
    @coursem[:course].should eq(Course.find(1))
    @coursem[:semester].should eq(Semester.find(1))
    @coursem[:resources].should eq([])
    @coursem = Coursem.getCoursemInformation(4)
    @coursem.should eq(-1)
  end

  before(:each) do
    @course = Course.new
    @course.createAll("computer science","blabla","CS","169","Spring", 2013, "George")
  end

  it "Does not allow a coursem_info with an empty string" do
    @course = Course.new
    @course.createCoursemByUser("Algorithm","","CS","169","Spring", 2013, "George").should eq(-8)
  end

  it "Does not allow a coursem_info that is not a string" do
    course = Course.new
    course.createCoursemByUser("Algorithm",007,"CS","169","Spring", 2013, "George").should eq(-8)
  end

  it "Does not allow a professor with an empty string" do
    course = Course.new
    course.createCoursemByUser("Algorithm",007,"CS","169","Spring", 2013, "").should eq(-9)
  end

  it "Does not allow a professor that is not a string" do
    course = Course.new
    course.createCoursemByUser("Algorithm",007,"CS","169","Spring", 2013, 007).should eq(-9)
  end

  it "Does not allow a existed coursem to be added" do
    course = Course.new
    course.createCoursemByUser("COMPUTER SCIENCE","blabla","CS","169","Spring", 2013, "GEORGE").should eq(-10)
  end

  it "Does allow a coursem with the right parameters get added" do
    course = Course.new
    course.createCoursemByUser("Algorithm","blabla","CS","170","Spring", 2013, "George").class.should eq(Coursem)
    course.createCoursemByUser("Probability","blabla","CS","170","Spring", 2013, "George").class.should eq(Coursem)
  end

  it "Does allow a deletion of a coursem in the DB" do
    puts "\nTest 10: Coursem in the DB can get deleted"
    @course = Coursem.new
    @course.createAll("computer science","blabla","CS","169","Spring", 2013, "George")
    @coursem = Coursem.first
    @coursem.destroyCoursem(@coursem.id).should eq(1)
  end

  it "Does not allow a deletion of a coursem not in the DB" do
    puts "\nTest 11: Coursem not in the DB doesn't get deleted"
    @coursem = Coursem.new
    @coursem.destroyCourse(@coursem.id).should eq(-22)
  end

end
