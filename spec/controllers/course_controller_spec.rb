require 'spec_helper'

describe CourseController do

  describe "GET index" do

    before (:each) do
      @course = mock_model(Course)
      Course.stub(:getCourseInformation).and_return([@course])
    end

    it "assigns @courses" do
      get :index, :dept => @course.department
      assigns(:courses).should eq([@course])
    end

    it "renders the index template" do
      get :index
      response.should render_template("index")
    end
  end

  describe "GET show" do

    before (:each) do
      @course = Course.create(:name => "a", :course_info => "b", :department => "c", :course_number => "d")
      Course.stub(:find_by_id).and_return(@course)
    end

    it "assigns @course" do
      @course1 = mock_model(Course)
      get :show, :id => @course1.id
      assigns(:course).should eq(@course)
    end

    it "renders the show template" do
      get :show, :id => @course.id
      response.should render_template("show")
    end

  end

end
