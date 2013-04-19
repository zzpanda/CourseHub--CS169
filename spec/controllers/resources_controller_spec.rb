require 'spec_helper'

  describe ResourcesController do
  	
  	describe "GET show" do

	    before (:each) do
	      @resource = mock_model(Resource)
	      Resource.stub(:find).and_return(@resource)
	    end

	    it "assigns @resource" do
	      Resource.should_receive(:find).once.and_return(@resource)
	      get :show, :id => @resource.id
	      assigns(:resource).should eq(@resource)
	    end
    end

    describe "GET new" do
    	login_admin

    	before (:each) do
	      @coursem = mock_model(Coursem)
	      Coursem.stub(:find).and_return(@coursem)
	    end

	    it "response should be successed" do
	      get :new, :coursem => @coursem.id, :user => subject.current_user.id
	      response.should be_success
	    end
    end

	describe "POST create" do

	    before (:each) do
	      @resource = mock_model(Resource)
	      Resource.stub(:new).and_return(@resource)
	      @resource.stub(:save).and_return(@resource)
	    end

	    it "response should be successed" do
	      Resource.should_receive(:new).once.and_return(@resource)
	      post :create, :resource => @recource
	      assigns(:resource).should eq(@resource)
	    end
	end 

	describe "POST addComment" do

	    before (:each) do
	      @comment = mock_model(Comment, :content => "A")
	      Comment.new.stub(:post_comment).and_return(1)
	    end

	    it "response should be successed" do
	      #Comment.new.should_receive(:new).once.and_return(@commentNew)
	      post :addComment, :comment => @comment, :user_id => 1, :resource_id => 1
	      assigns(:user_id).should eq("1")
	      assigns(:resource_id).should eq("1")
	      assigns(:result).should eq(1)
	    end
    end

    describe "#getResourcesType" do

	    it "assigns @dic" do
	      get :getResourcesType
	      response.should_not be_success
	    end

    end   

  end
