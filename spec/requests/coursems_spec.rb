require 'spec_helper'

describe "Coursems" do
  before :each do
    User.create(:email => "chris@gmail.com", :username=> "chris", :password=> "password")
    User.create(:email => "toby@gmail.com", :username=> "toby", :password=> "password")

    @course = Course.new
    @course.createAll("Software Engineering","Info","CS","169","Spring", 2013, "George Necula")
    @course.createAll("Algorithms", "Info", "CS","170","Spring",2013, "PapaD")
    @course.createAll("Linear Algebra","Info","Math","54","Fall", 2012, "Grunbaum")
  end

  def sign_in(email, password)
    visit '/'
    fill_in "user_email", :with => email
    fill_in "user_password", :with=> password
    click_button 'Sign in'
  end

  def add_resource(name, type, link)
    fill_in "resource_name", :with => name
    page.select type, :from => 'resource_type'
    fill_in "resource_link", :with => link
    click_button "Create Resource"
  end

  def add_comment(comment)
    fill_in "comment_box", :with => comment
    click_button "Save"
  end

  describe "GET /coursems" do

    it "Subscribe works and persists", :js => true do
      sign_in("chris@gmail.com","password")

      visit '/courses'
      click_link 'Goto' # goes to Software Engineering

      # Subscribe to coursem from coursem page
      click_button "Subscribe"
      visit '/users/coursems'
      page.should have_content("Software Engineering")
      page.should_not have_content("Algorithms")

      # Have the subscription perist even after logout
      click_link "Sign out"
      sign_in("chris@gmail.com","password")

      visit '/users/coursems'
      page.should have_content("Software Engineering")
      page.should_not have_content("Algorithms")
    end

    it "Add Resource", :js => true do
      sign_in("chris@gmail.com","password")

      visit '/courses'
      click_link 'Goto'

      find("#button_resources").click
      click_link "Add New Resource"
      add_resource('Homework 1', 'Homework', 'http://google.com')

      page.should have_content("Homework 1")
      click_link "Homework 1"
      within("#resource_description") do
        page.should have_content("chris")
        page.should have_content("Homework 1")
      end
      current_path.should == "/resources/1"
    end

    it 'Comments', :js => true do
      sign_in("chris@gmail.com","password")

      visit '/courses'
      click_link 'Goto'
      find("#button_resources").click
      click_link "Add New Resource"
      add_resource('Homework 1', 'Homework', 'http://google.com')
      click_link "Homework 1"
      add_comment("Thanks for the upload!")

      click_link "Sign out"
      sign_in("toby@gmail.com","password")

      visit '/courses'
      click_link "Goto"
      click_link "Homework 1"
      page.should have_content("Thanks for the upload!")

      add_comment("DANG!")
      page.should have_content("DANG!")
    end

    it 'Favorite a Resource', :js => true do
      sign_in("chris@gmail.com","password")

      # No favorite resources should be present initially
      visit '/'
      page.should_not have_content("Favorite Resources")

      # Add resource and favorite it
      visit '/courses'
      click_link 'Goto'
      find("#button_resources").click
      click_link "Add New Resource"
      add_resource('Homework 1', 'Homework', 'http://google.com')
      click_link "Homework 1"
      find("#favorite").click_button("Add To Favorite")


      # Check that it's been added to list of favorites
      visit '/'
      find("#favorite").should have_content('Homework 1')
      find("#favorite").should have_content("CS 169")

      # Then delete the favorite
      visit '/courses'
      click_link 'Goto'
      click_link "Homework 1"
      find("#favorite").click_button("Delete Favorite")

      # Check it's been deleted
      visit '/'
      page.should_not have_content("Favorite Resources")
    end

    it "Feed of Recent Resources", :js => true do
      sign_in("chris@gmail.com","password")

      # No recent resources should be present
      find("#Feed").should_not have_content("Homework 1")

      # Add a resource, but don't subscribe to that course
      visit '/courses'
      click_link "Goto"
      find("#button_resources").click
      click_link "Add New Resource"
      add_resource("Homework 1", "Homework","http//google.com")

      visit '/'
      find("#Feed").should_not have_content("Homework 1")

      # Subscribe to the course
      visit '/courses'
      click_link 'Goto'
      click_button 'Subscribe'

      visit '/'
      find("#Feed").should have_content("Homework 1")
      find("#Feed").should have_content("CS 169")
    end

  end


end
