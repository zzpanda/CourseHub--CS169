require 'spec_helper'
require 'course'

describe Course do


  before(:each) do
    @course = Course.new
    @course.createAll("computer science","blabla","CS","169","Spring", 2013, "George")
    @course.createAll("computer science","blabla","CS","169","Fall", 2012, "A")
    @course.createAll("computer science","blabla","CS","170","Fall", 2012, "B")
    @course1 = Course.find(1)
    @course2 = Course.find(2)
    @semester1 = Semester.find(1)
    @semester2 = Semester.find(2)
    @coursem1 = Coursem.find(1)
    @coursem2 = Coursem.find(2)
    @coursem3 = Coursem.find(3)
  end

  it "should create the correct course" do
    @course1.name.should eq("computer science")
    @course1.course_info.should eq("blabla")
    @course1.department.should eq("CS")
    @course1.course_number.should eq("169")
  end

  it "should create the correct semester" do
    @semester2.term.should eq("Fall")
    @semester2.year.should eq(2012)
  end

  it "should create the correct course_semester" do
    @coursem3.professor.should eq("B")
  end

  it "should have only two semesters" do
    Semester.all.length.should eq(2)
  end

  it "should have only two courses" do
    Course.all.length.should eq(2)
  end

  it "Semester have a list to store the courses having the same semester" do
    @semester1.courses.length.should eq(1)
    @semester2.courses.length.should eq(2)
  end

  it "Course have a list to store the semesters having the same semester" do
    @course1.semesters.length.should eq(2)
    @course2.semesters.length.should eq(1)
  end

  it "Semester have a list to store the coursems having the same semester" do
    @semester1.coursems.length.should eq(1)
    @semester2.coursems.length.should eq(2)
  end

  it "Course have a list to store the coursems having the same semester" do
    @course1.coursems.length.should eq(2)
    @course2.coursems.length.should eq(1)
  end

  it "should filter the courses using department" do
    @courses = Course.getCourseInformation("CS")
    @courses.length.should eq(2)
    @courses = Course.getCourseInformation("SC")
    @courses.length.should eq(0)
  end
end

