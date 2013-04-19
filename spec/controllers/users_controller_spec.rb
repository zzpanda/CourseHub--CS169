require 'spec_helper'

  describe UsersController do
	  login_admin

	  it "should have a current_user" do
	    subject.current_user.should_not be_nil
	  end

	  describe "GET edit" do

	    before (:each) do
	      @user = mock_model(User, :email => "zhangzhuo1021@gmail.com", :username => "zhangzhuo1021")
	    end

	    it "should edit username and email, and return it" do
	      get :edit, :email => @user.email, :username => @user.username
	      response.should be_success
	    end
	  end

	  describe "GET show" do

	    before (:each) do
	      @user = mock_model(User, :month => 10, :year => 2012)
	      @coursem = mock_model(Coursem)
	      User.stub(:find).and_return(@user)
	      @user.stub(:subscribed).and_return([@coursem])
	    end

	    it "assigns @email" do
	      get :show, :id => @user.id, :month => @user.month, :year => @user.year
	      assigns(:email).should eq(subject.current_user.email)
	    end

	    it "assigns @coursems" do
	      get :show, :id => @user.id, :month => @user.month, :year => @user.year
	      assigns(:coursems).should eq([@coursem])
	    end
	  end

	  describe "#subscribe" do

	    before (:each) do
	      #subject.current_user.stub(:subscribe).with("1").and_return()
	    end

	    it "should suscribe correct coursem" do
	      #subject.current_user.should_receive(:subscribe).once.with("1").and_return()
	      get :subscribe
	      response.should be_success
	    end
	  end

	  describe "#unsubscribe" do

	    before (:each) do
	      #subject.current_user.stub(:subscribe).with("1").and_return()
	    end

	    it "should suscribe correct coursem" do
	      #subject.current_user.should_receive(:subscribe).once.with("1").and_return()
	      get :unsubscribe
	      response.should be_success
	    end
	  end

end
