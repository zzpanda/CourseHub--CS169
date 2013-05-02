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
    it "sign up successfully" do
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

    it 'incorrect registration - no password' do
      visit "/users/sign_in"
      click_link "Sign up"
      fill_in "user_username", :with => "testuser"
      fill_in "user_email", :with => "testuser@example.com"
      click_button "Sign up"
      current_path.should == "/users"
      page.should have_content("Sign up")
    end

    it 'incorrect registration - email already taken' do
      visit "/users/sign_in"
      click_link "Sign up"
      fill_in "user_username", :with => "testuser"
      fill_in "user_email", :with => "test@example.com"
      fill_in "user_password", :with => "password"
      fill_in "user_password", :with => "password"
      click_button "Sign up"

      page.should have_content("Sign up")
    end

    it 'incorrect registration - passwords do no match' do
      visit "/users/sign_in"
      click_link "Sign up"
      fill_in "user_username", :with => "testuser2"
      fill_in "user_email", :with => "testuser2@example.com"
      fill_in "user_password", :with => "password"
      fill_in "user_password", :with => "pass"
      click_button "Sign up"

      current_path.should == "/users"
      page.should have_content("Sign up")
    end


    it "sign in successfully" do
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
