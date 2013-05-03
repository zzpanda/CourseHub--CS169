require 'spec_helper'

  describe ResourcesController do
  	
  	describe "GET show" do

	    before (:each) do
	      @user = FactoryGirl.create(:user)
      	  sign_in @user
      	  controller.stub!(:current_user).and_return(@user)
	    end

	    it "assigns @resource" do
	      @resource = mock_model(Resource, :users_who_flagged => "1,2,3")
	      Resource.stub(:find).and_return(@resource)
	      Resource.should_receive(:find).once
	      get :show, :id => @resource.id
	      assigns(:resource).should eq(@resource)
	    end

	    it "assigns flags to false if a user haven't flag this resource before" do
	        @resource = mock_model(Resource, :users_who_flagged => "2,3")
	        Resource.stub(:find).and_return(@resource)
	    	get :show, :id => @resource.id
	        assigns(:flag).should eq(false)
	   	end
    end

    describe "GET new" do

    	before (:each) do
    	  @user = FactoryGirl.create(:user)
          sign_in @user
	      @coursem = mock_model(Coursem)
	      Coursem.stub(:find).and_return(@coursem)
	    end

	    it "response should be successed" do
	      get :new, :coursem => @coursem.id, :user => @user.id
	      response.should be_success
	    end
    end

	describe "POST create" do

	    before (:each) do
	      @user = FactoryGirl.create(:user)
          sign_in @user
          controller.stub!(:current_user).and_return(@user)
	      @resource = mock_model(Homework, :name=>"Homework 1",:type=>"Homework",:link=>"http://google.com",:user_id=>@user.id, :coursem_id=>1)
	      @re = {:name => @resource.name, :type => @resource.type, :link => @resource.link, :user_id => @resource.user_id, :coursem_id => @resource.coursem_id}
	      @user.stub(:addResource).and_return(@resource)
	    end

	    it "response should be successed" do
	      @user.should_receive(:addResource).once
	      post :create, :resource => @re
	      assigns(:resource).should eq(@resource)
	    end
	end 

	describe "POST addComment" do

	    before (:each) do
	      @user = FactoryGirl.create(:user)
          sign_in @user
	      @comment = mock_model(Comment, :content => "A")
	      Comment.new.stub(:post_comment).and_return(1)
	    end

	    it "response should be successed" do
	      #Comment.new.should_receive(:new).once.and_return(@commentNew)
	      post :addComment, :comment => @comment, :user_id => 1, :resource_id => 1
	      assigns(:user_id).should eq(1)
	      assigns(:resource_id).should eq("1")
	      assigns(:result).should eq(1)
	    end
    end

    describe "#getResourcesType" do
    	before (:each) do
    	  @user = FactoryGirl.create(:user)
          sign_in @user
        end

	    it "assigns @dic" do
	      get :getResourcesType
	      response.should_not be_success
	    end

    end

    describe "GET checkFavorite" do

	    before (:each) do
	      @user = FactoryGirl.create(:user)
	      sign_in @user
	      controller.stub!(:current_user).and_return(@user)
	      @favorite = mock_model(Favorite)
	      @user.stub!(:favorite).and_return(@favorite)
	      @resource = mock_model(Resource)
	      @favorite.stub!(:resources).and_return([@resource])
	    end

	    it "assigns @boolean" do
	      @user.should_receive(:favorite).once
	      get :checkFavorite, :resource_id => @resource.id
	      assigns(:boolean).should eq(true)
	    end
	end

	describe "#flag" do

		it "should flag a correct resource" do
		  @user = FactoryGirl.create(:user)
		  sign_in @user
		  controller.stub!(:current_user).and_return(@user)
		  @resource = mock_model(Resource)
		  @user.stub!(:flagResource).and_return(2)
		  post :flag, :resource_id => @resource.id
		  assigns(:flags).should eq(2)
	    end

		it "shouldn't flag a correct resource without sign in" do
		  @resource = mock_model(Resource)
		  post :flag, :resource_id => @resource.id
		  response.should_not be_success
		end
	end

	describe "#unflag" do

		it "should unflag a correct resource" do
		  @user = FactoryGirl.create(:user)
		  sign_in @user
		  controller.stub!(:current_user).and_return(@user)
		  @resource = mock_model(Resource)
		  @user.stub!(:unFlagResource).and_return(2)
		  post :unFlag, :resource_id => @resource.id
		  assigns(:flags).should eq(2)
		end

		it "shouldn't flag a correct resource without sign in" do
		  @resource = mock_model(Resource)
		  post :unFlag, :resource_id => @resource.id
		  response.should_not be_success
		end
	end 

  end
