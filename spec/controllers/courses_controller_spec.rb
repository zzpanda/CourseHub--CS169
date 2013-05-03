require 'spec_helper'

describe CoursesController do

  describe "GET index" do

    before (:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @course = mock_model(Course)
      Course.stub(:getCourseInformation).and_return([@course])
    end

    it "assigns @course" do
      Course.should_receive(:getCourseInformation).once.and_return([@course])
      get :index
      assigns(:courses).should eq([@course])
    end

    it "renders the index template" do
      get :index
      response.should render_template("index")
    end
  end

  describe "GET checkSubscribed" do

    before (:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @coursem = mock_model(Coursem)
      @user.stub!(:subscribed).and_return([@coursem])
      controller.stub!(:current_user).and_return(@user)
    end

    it "assigns @subscribed" do
      @user.should_receive(:subscribed).once
      get :checkSubscribed
      assigns(:subscribed).should eq([@coursem])
    end
  end

  describe "#getDepartment" do

    before (:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @course = mock_model(Course)
      Course.stub(:getDepartments).and_return([@course])
    end

    it "assigns @dic" do
      Course.should_receive(:getDepartments).once.and_return([@course])
      get :getDepartment
      assigns(:dic).should eq([@course])
    end

  end

  describe "GET show" do

    before (:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @course = mock_model(Course, :id => "1", :name => "Algorithm")
      Course.stub(:find_by_id).and_return(@course)
    end

    it "assigns @course" do
      Course.should_receive(:find_by_id).once
      get :show, :id => @course.id
      assigns(:course).should eq(@course)
    end

    it "renders the show template" do
      get :show, :id => @course.id
      response.should render_template("show")
    end

    it "renders pubic page if couse is nil" do
      Course.stub(:find_by_id).and_return(nil)
      get :show, :id => @course.id
      response.should render_template("layouts/application")
    end

  end

  describe "GET resources" do

    before (:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @course = mock_model(Course)
      Course.stub(:find_by_id).and_return(@course)
    end

    it "assigns @course" do
      Course.should_receive(:find_by_id).once
      get :resources, :courseid => @course.id
      assigns(:course).should eq(@course)
    end
  end

end
