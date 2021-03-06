require 'spec_helper'
require 'course'

describe Course do

  before(:each) do
    @course = Course.new
    @course.createAll("Computer Science","Blabla","CS","169","SPRING", 2013, "GEORGE")
    @course.createAll("Computer Science","Blabla","CS","169","FALL", 2012, "A")
    @course.createAll("Computer Science","Blabla","CS","170","FALL", 2012, "B")
    @course1 = Course.find(1)
    @course2 = Course.find(2)
    @semester1 = Semester.find(1)
    @semester2 = Semester.find(2)
    @coursem1 = Coursem.find(1)
    @coursem2 = Coursem.find(2)
    @coursem3 = Coursem.find(3)
  end

  it "should get the right departments" do
    @departments = Course.getDepartments()
    @departments.should eq(["CS", "OTHERS"])
  end

  it "should create the correct course" do
    @course1.name.should eq("Computer Science")
    @course1.department.should eq("CS")
    @course1.course_number.should eq("169")
  end

  it "should create the correct semester" do
    @semester2.term.should eq("FALL")
    @semester2.year.should eq(2012)
  end

  it "should create the correct course_semester" do
    @coursem3.professor.should eq("B")
    @coursem1.coursem_info.should eq("Blabla")
  end

  it "should have only two semesters" do
    Semester.all.length.should eq(2)
  end

  it "should have only two course" do
    Course.all.length.should eq(2)
  end

  it "Semester have a list to store the course having the same semester" do
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

  it "should filter the course using department" do
    @courses = Course.getCourseInformation("CS","169")
    @courses.length.should eq(1)
    @courses = Course.getCourseInformation("CS","")
    @courses.length.should eq(2)
    @courses = Course.getCourseInformation("","169")
    @courses.length.should eq(1)
    @courses = Course.getCourseInformation("","")
    @courses.length.should eq(2)
    @courses = Course.getCourseInformation("SC", "169")
    @courses.length.should eq(0)
  end

  it "Does not allow a course name with an empty string" do
    puts "Test 1: Course with course name that is an empty string doesn't get added"
    course = Course.new
    course.createCourse("","department",123).should eq(-1)
  end

  it "Does not allow a course name that is not a string" do
    puts "\nTest 2: Course with course name not a string doesn't get added"
    course = Course.new
    course.createCourse(007, "department", 123).should eq(-1)
  end

  it "Does not allow a department with an empty string" do
    puts "\nTest 5: Course with department that is an empty string doesn't get added"
    course = Course.new
    course.createCourse("name", "", 123).should eq(-2)
  end


  it "Does not allow a department that is not a string" do
    puts "\nTest 6: Course with department that is not a string doesn't get added"
    course = Course.new
    course.createCourse("name", 007, 123).should eq(-2)
  end

  it "Does not allow a course_number that is not an String" do
    puts "\nTest 7: Course with course_number that is not an Integer doesn't get added"
    course = Course.new
    course.createCourse("name", "department", 007 ).should eq(-3)
  end


  it "Does allow a course with the right parameters get added" do
    puts "\nTest 8: Course with right parameters get added"
    course = Course.new
    course.createCourse("name", "department", "007").class.should eq(Course)
  end

  it "Does allow a deletion of a course in the DB" do
    puts "\nTest 10: Course in the DB can get deleted"
    @course = Course.new
    @course = @course.createCourse("name", "department", "007")
    @course.destroyCourse(@course.id).should eq(1)
  end

  it "should destroy the coursem corresponding to the course" do
    @course1.destroy
    Coursem.all.length.should eq(1)
  end

  it "Does not allow a deletion of a course not in the DB" do
    puts "\nTest 11: Course not in the DB doesn't get deleted"
    @course = Course.new
    @course.destroyCourse(@course.id).should eq(-20)
  end

end

