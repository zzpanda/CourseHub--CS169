require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "doesn't accept bad logins" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit "/users/sign_in"
      page.should have_content("Sign in")
      current_path.should == "/users/sign_in"
      fill_in "user_email", :with => "dontauth@example.com"
      fill_in "user_password", :with=> "bad password"

      page.should have_content("Sign in")
      current_path.should == "/users/sign_in"
    end
    it "lets users sign up" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit "/users/sign_in"
      click_link "Sign up"
      current_path.should == "/users/sign_up"
      fill_in "user_email", :with => "testuser@example.com"
      fill_in "user_password", :with=> "testuserpassword"
      fill_in "user_password_confirmation", :with=> "testuserpassword"
      click_button "Sign up"
      current_path.should == "/"
      page.should have_content("User Profile")
      page.should have_content("Your current courses:")
    end

  end
end
