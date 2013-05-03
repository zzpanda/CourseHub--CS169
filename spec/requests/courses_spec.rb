require 'spec_helper'
#See here for help on generating this file:
#http://railscasts.com/episodes/257-request-specs-and-capybara?autoplay=true
# need to run rake db:test:prepare
describe "Courses" do
  before :each do
    User.create(:email => "test@example.com", :username=> "testuser", :password=> "password")
    @course = Course.new
    @course.createAll("Software Engineering","Info","CS","169","Spring", 2013, "George")
    @course.createAll("Linear Algebra","Info","Math","54","Fall", 2012, "A")
    @course1 = Course.find(1)
    @course2 = Course.find(2)
    @semester1 = Semester.find(1)
    @semester2 = Semester.find(2)
    @coursem1 = Coursem.find(1)
    @coursem2 = Coursem.find(2)

    visit '/'
    fill_in "user_email", :with => "test@example.com"
    fill_in "user_password", :with=> "password"
    click_button 'Sign in'
    #Course.create(:name => "Software Engineering", :department=> "CS", :course_number=> "169")
    #Course.create(:name => "Linear Algebra", :department=> "Math", :course_number=> "54")
  end
  describe "GET /courses", :js => false do
    it "filter courses by department" do
      visit '/courses'
      current_path.should == "/courses"
      page.should have_content("MATH")
      click_link "CS"
      page.should have_content("CS")
      page.should have_content("Software Engineering")
      page.should_not have_content("MATH")
    end

    it "link to coursem page", :js => true do
      visit '/courses'
      current_path.should == "/courses"
      click_link "Goto"
      current_path.should == "/coursem/1"
      page.should have_content("CS")
    end

    it "view all link", :js => true do
      visit '/courses'
      click_link "CS"
      click_link "View All"
      current_path.should == "/courses"
      page.should have_content("CS")
      page.should have_content("MATH")
    end

    it "search for course", :js => true do
      visit '/courses'
      current_path.should == "/courses"
      page.fill_in 'search_department', :with => 'Math'
      page.fill_in 'search_course', :with => '54'
      click_button "button_search"

      current_path.should == "/courses"
      click_link "Goto"

      current_path.should == "/coursem/2"
      page.should have_content("MATH")
      page.should have_content("Linear Algebra")
      page.should_not have_content("CS")

    end

    it 'subscribe/unsubscribe from course', :js => true do
      visit '/users/coursems'
      page.should_not have_content("CS")
      page.should_not have_content("Software Engineering")

      visit '/courses'
      click_button "Subscribe" # clicks first subscribe button which
      # is CS 169
      visit '/users/coursems'
      page.should have_content("CS")
      page.should have_content("Software Engineering")

      visit '/courses'
      page.should have_content("Unsubscribe")
      click_button "Unsubscribe"
      visit '/users/coursems'
      page.should_not have_content("CS")
      page.should_not have_content("Software Engineering")
    end
  end
end
