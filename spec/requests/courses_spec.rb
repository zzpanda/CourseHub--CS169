require 'spec_helper'
#See here for help on generating this file:
#http://railscasts.com/episodes/257-request-specs-and-capybara?autoplay=true
describe "Courses" do
  describe "GET /courses" do
    it "links to signin" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers

      visit courses_path
      page.should have_content("sign in")
      page.click_link "sign in"
      current_path.should == "/users/sign_in"


    end
    it "has sign up" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit courses_path
      page.should have_content("Sign up")
      page.click_link "Sign up"
      current_path.should == "/users/sign_up"

    end
  end
end
