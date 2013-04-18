require 'spec_helper'
#See here for help on generating this file:
#http://railscasts.com/episodes/257-request-specs-and-capybara?autoplay=true
# need to run rake db:test:prepare
describe "Courses" do
  before :each do
    Course.create(:name => "Software Engineering", :department=> "CS", :course_number=> "169")
    Course.create(:name => "Linear Algebra", :department=> "Math", :course_number=> "54")
  end
  describe "GET /courses" do
    it "filters" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit courses_path
      page.should have_content("Math")
      click_link "CS"

      page.should_not have_content("Math")
    end
    it "links to course" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit courses_path
      click_link "Software Engineering"

      current_path.should == "/courses/1"
      page.should have_content("Software Engineering")
      page.should_not have_content("Algorithms")
    end

  end
end
