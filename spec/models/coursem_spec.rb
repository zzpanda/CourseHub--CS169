require 'spec_helper'
require 'coursem'

describe Coursem do

  before(:each) do
    @course = Course.new
    @course.createAll("Computer Science","Blabla","CS","169","SPRING", 2013, "GEORGE")
  end

  it "should create the correct coursem in database" do
    Coursem.createCourseSemesters("George", 2, 3, "blabla")
    @coursem = Coursem.find_by_course_id_and_semester_id(2, 3)
    @coursem.professor.should eq("George")
    @coursem = Coursem.find_by_course_id_and_semester_id(3, 5)
    @coursem.should eq(nil)
  end

  it "should get correct course information" do
    @course = Course.new
    @course.createAll("computer science","blabla","CS","169","Fall", 2012, "A")
    @course.createAll("computer science","blabla","CS","170","Fall", 2012, "B")
    @coursem = Coursem.getCoursemInformation(1)
    @coursem[:users].should eq([])
    @coursem[:courses].should eq(Course.find(1))
    @coursem[:semester].should eq(Semester.find(1))
    @coursem[:resources].should eq([])
    @coursem = Coursem.getCoursemInformation(4)
    @coursem.should eq(-1)
  end

  it "Does not allow a coursem_info with an empty string" do
    Coursem.createCoursemByUser("Algorithm","","CS","169","SPRING", 2013, "GEORGE").should eq(-8)
  end

  it "Does not allow a coursem_info that is not a string" do
    Coursem.createCoursemByUser("Algorithm",007,"CS","169","SPRING", 2013, "GEORGE").should eq(-8)
  end

  it "Does not allow a professor with an empty string" do
    Coursem.createCoursemByUser("Algorithm","Blabla","CS","169","SPRING", 2013, "").should eq(-9)
  end

  it "Does not allow a professor that is not a string" do
    Coursem.createCoursemByUser("Algorithm", "Blabla","CS","169","SPRING", 2013, 007).should eq(-9)
  end

  it "Does not allow a existed coursem to be added" do
    Coursem.createCoursemByUser("Computer Science","Blabla","CS","169","SPRING", 2013, "GEORGE").should eq(-10)
  end

  it "Does allow a coursem with the right parameters get added" do
    Coursem.createCoursemByUser("Algorithm","Blabla","CS","170","SPRING", 2013, "GEOGRE").class.should eq(Coursem)
    Coursem.createCoursemByUser("Probability","Blabla","CS","70","SPRING", 2013, "GEORGE").class.should eq(Coursem)
  end

  it "Does allow a deletion of a coursem in the DB" do
    puts "\nTest 10: Coursem in the DB can get deleted"
    @course = Course.new
    @course.createAll("Computer Science","Blabla","CS","169","SPRING", 2013, "GEOGRE")
    @coursem = Coursem.first
    @coursem.destroyCoursem(@coursem.id).should eq(1)
  end

  it "Does not allow a deletion of a coursem not in the DB" do
    puts "\nTest 11: Coursem not in the DB doesn't get deleted"
    @coursem = Coursem.new
    @coursem.destroyCoursem(@coursem.id).should eq(-22)
  end

end
