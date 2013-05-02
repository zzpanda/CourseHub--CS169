require 'spec_helper'

describe "Users" do
  before :each do
    User.create(:email => "test@example.com", :username=> "testusername", :password=> "asdfasdf")
  end
  describe "GET /users/sign_in" do
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
      fill_in "user_username", :with => "testuser"
      fill_in "user_email", :with => "testuser@example.com"
      fill_in "user_password", :with=> "testuserpassword"
      fill_in "user_password_confirmation", :with=> "testuserpassword"
      click_button "Sign up"
      current_path.should == "/"
      page.should have_content("Home Page")
    end
    it "lets users sign in" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit "/users/sign_in"
      fill_in "user_email", :with => "test@example.com"
      fill_in "user_password", :with=> "asdfasdf"
      click_button "Sign in"
      current_path.should == "/"
      page.should have_content("Home Page")
    end

  end
  describe "GET /users" do
    before :each do
      User.create(:email => "test@example.com", :username=> "testusername", :password=> "asdfasdf")
      visit "/users/sign_in"
      fill_in "user_email", :with => "test@example.com"
      fill_in "user_password", :with=> "asdfasdf"
      click_button "Sign in"
    end
    it "is signed in" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit "/"
      current_path.should == "/"
      page.should have_content("Home Page")
    end
  end
end
