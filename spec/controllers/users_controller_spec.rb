require 'spec_helper'

  describe UsersController do

	  describe "GET home" do

	    before (:each) do
	      @user = FactoryGirl.create(:user)
          sign_in @user
	      @user = mock_model(User, :email => "zhangzhuo1021@gmail.com", :username => "zhangzhuo1021")
	      @coursem = mock_model(Coursem)
	      User.stub(:find).and_return(@user)
	      @user.stub(:subscribed).and_return([@coursem])
	      @favorite = mock_model(Favorite)
	      @resource = mock_model(Resource)
	    end

	    it "should edit username and email, and return it" do
	      get :home, :month => 10, :year => 2013, :id => @user.id
	      response.should be_success
	    end

	    it "should get current_user id" do
	      controller.stub!(:current_user).and_return(@user)
	      @user.stub!(:favorite).and_return(@favorite)
	      @favorite.stub!(:resources).and_return([@resource])
	      get :home, :month => 10, :year => 2013, :id => nil
	      assigns(:id).should eq(@user.id)
	    end
	  end

	  describe "GET show" do

	    before (:each) do
	      @user = mock_model(User, :month => 10, :year => 2012)
	      @coursem = mock_model(Coursem)
	      @resource = mock_model(Resource)
	      User.stub(:find).and_return(@user)
	      @user.stub(:coursems).and_return([@coursem])
	      @user.stub(:resources).and_return([@resource])
	    end

	    it "assigns correctly" do
	      get :show, :id => @user.id
	      assigns(:user).should eq(@user)
	      assigns(:coursems).should eq([@coursem])
	      assigns(:resources).should eq([@resource])
	      assigns(:viewingProfile).should eq(true)
	    end
	  end

	  describe "#subscribe" do

	    it "should suscribe correct coursem" do
	      @user = FactoryGirl.create(:user)
          sign_in @user
	      post :subscribe
	      response.should be_success
	    end

	    it "shouldn't subscribe without sign in" do
	      post :subscribe
	      response.should be_success
		end
	  end

	  describe "#unsubscribe" do

	    it "should suscribe correct coursem" do
	      @user = FactoryGirl.create(:user)
          sign_in @user
	      post :unsubscribe
	      response.should be_success
	    end

	    it "shouldn't subscribe without sign in" do
	      post :unsubscribe
	      response.should be_success
		end
	  end

	  describe "#addFavorite" do

	    it "should add correct favorite resources" do
	      @user = FactoryGirl.create(:user)
          sign_in @user
          controller.stub!(:current_user).and_return(@user)
          @resource = mock_model(Resource)
       	  User.stub!(:find).and_return(@user)
          @user.stub!(:addToFavorite).and_return(@resource)
	      post :addFavorite, :resource_id => @resource.id
	      response.should be_success
	    end

	    it "shouldn't add favorite without sign in" do
	      post :addFavorite
	      response.should be_success
		end
	  end

	  describe "#deleteFavorite" do

	    it "should delete correct favorite resources" do
	      @user = FactoryGirl.create(:user)
          sign_in @user
          controller.stub!(:current_user).and_return(@user)
          @resource = mock_model(Resource)
       	  User.stub!(:find).and_return(@user)
          @user.stub!(:deleteFavorite).and_return(@resource)
	      post :deleteFavorite, :resource_id => @resource.id
	      response.should be_success
	    end

	    it "shouldn't delete favorite without sign in" do
	      post :deleteFavorite
	      response.should be_success
		end
	  end

	  describe "GET resources" do

	    before (:each) do
	      @user = FactoryGirl.create(:user)
	      sign_in @user
	      controller.stub!(:current_user).and_return(@user)
	      @coursem = mock_model(Coursem)
	      @user.stub!(:coursems).and_return([@coursem])
	    end

	    it "assigns @course" do
	      @user.should_receive(:coursems).once
	      get :coursems
	      assigns(:coursems).should eq([@coursem])
	    end
	  end

  end
