require 'spec_helper'

describe CoursemController do

  describe "GET show" do
    before(:each) do
      @coursem = mock_model(Coursem)
      Coursem.stub(:getCoursemInformation).and_return(@coursem)
    end

    #it "assigns @coursem" do
    #  get :show, :id => @coursem.id
    #  assigns(:coursem).should eq(@coursem)
    #end

    #it "renders the show template" do
    #  get :show, :id => @coursem.id
    #  response.should render_template("show")
    #end


  end
end
