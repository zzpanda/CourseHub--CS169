require 'spec_helper'

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


    end
  end
end
