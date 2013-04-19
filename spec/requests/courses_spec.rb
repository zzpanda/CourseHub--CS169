require 'spec_helper'
#See here for help on generating this file:
#http://railscasts.com/episodes/257-request-specs-and-capybara?autoplay=true
# need to run rake db:test:prepare
describe "Courses" do
  before :each do
    @course = Course.new
    @course.createAll("Software Engineering","blabla","CS","169","Spring", 2013, "George")
    @course.createAll("Linear Algebra","blabla","Math","54","Fall", 2012, "A")
    @course1 = Course.find(1)
    @course2 = Course.find(2)
    @semester1 = Semester.find(1)
    @semester2 = Semester.find(2)
    @coursem1 = Coursem.find(1)
    @coursem2 = Coursem.find(2)
    #Course.create(:name => "Software Engineering", :department=> "CS", :course_number=> "169")
    #Course.create(:name => "Linear Algebra", :department=> "Math", :course_number=> "54")
  end
  describe "GET /courses" do
    it "filters" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit courses_path
      page.should have_content("Math")
      click_link "CS"
      page.should have_content("CS")
      page.should have_content("Software Engineering")
      page.should_not have_content("Math")
    end
    it "links to course" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit courses_path
      click_link "Software Engineering"

      current_path.should == "/courses/1"
      page.should have_content("Software Engineering")
      page.should_not have_content("Linear Algebra")
    end
    it "links to coursem", :js => true do
      visit courses_path
      click_link "View Coursem"
      current_path.should have_content("/course/")
    end
  end
end
