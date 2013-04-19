require 'spec_helper'

describe CoursemController do

  describe "GET show" do
    login_admin

    before (:each) do
      @course = Course.create(:name => "A", :department => "CS", :course_number => "169")
      @semester = Semester.create(:term => "FALL", :year => 2012)
      @coursem = Coursem.create(:course_id => "1", :professor => "GEROGE", :semester_id => "1", :coursem_info => "A")
      Coursem.stub(:getCoursemInformation).and_return(@coursem)
    end

    it "assigns @coursem to true Coursem Object" do
      Coursem.should_receive(:getCoursemInformation).once
      get :show, :id => @coursem.id
      assigns(:coursem).should eq(@coursem)
    end

    it "assigns @coursem to errCode" do
      Coursem.should_receive(:getCoursemInformation).once.and_return(-1)
      get :show, :id => @coursem.id
      assigns(:coursem).should eq(-1)
    end

    it "renders the show template" do
      get :show, :id => @coursem.id
      response.should render_template("show")
    end

  end

  describe "POST create" do
    before do
      @coursem = mock_model(Coursem)
      Coursem.stub(:createCoursemByUser).and_return(@coursem)
    end

    it "assigns @coursem" do
      Coursem.should_receive(:createCoursemByUser).once
      post :create, :unit => "2", :coursem_info => "A"
      assigns(:new).should eq(@coursem)
    end
  end

end
