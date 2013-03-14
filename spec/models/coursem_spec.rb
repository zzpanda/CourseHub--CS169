require 'spec_helper'
require 'coursem'

describe Coursem do
  it "should create the correct coursem in database" do
    Coursem.createCourseSemesters("George", 2, 3)
    @coursem = Coursem.find_by_course_id_and_semester_id(5, 5)
    @coursem.professor.should eq("George")
    @coursem = Coursem.find_by_course_id_and_semester_id(3, 5)
    @coursem.professor.should eq("George")
  end

end
