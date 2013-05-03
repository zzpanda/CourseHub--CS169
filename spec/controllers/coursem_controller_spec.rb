require 'spec_helper'


describe CoursemController do

  describe "GET show" do

    before (:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
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

    it "assigns @subscribe_text to Unsubscribe if user subscribe the coursem" do
      controller.stub!(:current_user).and_return(@user)
      @user.stub!(:subscribed?).and_return(true)
      get :show, :id => @coursem.id
      assigns(:subscribe_text).should eq("Unsubscribe")
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
      @user = FactoryGirl.create(:user)
      sign_in @user
      @coursem = mock_model(Coursem)
      Coursem.stub(:createCoursemByUser).and_return(@coursem)
    end

    it "assigns @coursem" do
      Coursem.should_receive(:createCoursemByUser).once
      post :create, :unit => "2", :coursem_info => "A"
      assigns(:coursem).should eq(@coursem)
      assigns(:errCode).should eq(1)
    end
  end

  describe "GET new" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
      Course.stub(:getDepartments).and_return(["EE","CS"])
      @coursem = mock_model(Coursem)
      Coursem.stub(:new).and_return(@coursem)
    end

    it "assigns @coursem" do
      Course.should_receive(:getDepartments).once
      Coursem.should_receive(:new).once
      get :new 
      assigns(:coursem).should eq(@coursem)
      assigns(:departments).should eq(["EE","CS"])
    end

    it "renders the form partial" do
      get :new
      response.should render_template("form")
    end
  end

end
