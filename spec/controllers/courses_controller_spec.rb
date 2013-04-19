require 'spec_helper'

describe CoursesController do

  describe "GET index" do

    before (:each) do
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

  describe "#getDepartment" do

    before (:each) do
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
      @course = mock_model(Course, :id => "1", :name => "Algorithm")
      Course.stub(:find_by_id).and_return(@course)
    end

    it "assigns @course" do
      Course.should_receive(:find_by_id).once.and_return(@course)
      get :show, :id => @course.id
      assigns(:course).should eq(@course)
    end

    it "renders the show template" do
      get :show, :id => @course.id
      response.should render_template("show")
    end

  end

end
