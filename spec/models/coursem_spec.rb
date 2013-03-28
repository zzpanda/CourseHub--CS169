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
    #@coursem[:resources].should eq([])
    @coursem = Coursem.getCoursemInformation(4)
    @coursem.should eq(-1)
  end
end
