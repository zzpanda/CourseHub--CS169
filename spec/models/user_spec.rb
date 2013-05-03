require 'spec_helper'

describe User do



  before(:each) do
    @user1 = User.create!(username: "Example User", email: "user@example.com", password: "aaaaaaaa")
    Course.new.createAll("computer science","blabla","CS","169","Spring", 2013, "George")
    @coursem1 = Coursem.first
    @user1.addResource("Example Resource", "Homework", "http://ExampleResource.com", @user1.id, @coursem1.id)
    @resource1id = Resource.find_by_name_and_link("Example Resource", "http://ExampleResource.com").id
    @user1.addResource("a", "Discussion", "http://c.com", @user1.id, @coursem1.id)

    @otheruser = User.create!(username: "Other UserR", email: "user@other.com", password: "bbbbbbbb")
    @otheruser.addResource("Other Resource", "Homework", "http://OtherResource.com", @otheruser.id, @coursem1.id)
    @resource2id = Resource.find_by_name_and_link("Other Resource", "http://OtherResource.com").id
  end

  subject { @user1 }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:karma) }
  it { should respond_to(:resources) }
  it { should respond_to(:comments) }
  it { should respond_to(:coursems) }
  it { should respond_to(:subscribe) }
  it { should respond_to(:unsubscribe) }
  it { should respond_to(:subscribed?) }
  it { should respond_to(:subscribed) }
  it { should respond_to(:editProfile) }
  it { should respond_to(:addResource) }
  it { should respond_to(:postedResource?) }
  it { should respond_to(:postedResources) }
  it { should respond_to(:addComment) }
  it { should respond_to(:commentsBy) }

  describe "#addResource" do
    it "should add a resource" do
      Resource.find_by_name_and_link("Example Resource", "http://ExampleResource.com").should_not == nil
    end
  end

  describe "#postedResource?" do
    it "should return true if user posted the resource" do
      @user1.postedResource?(@resource1id).should == true
    end
    it "should return false if user did not post the resource" do
      @user1.postedResource?(@resource2id).should == false
    end
  end

  describe "#postedResources" do
    it "should return a list of resources user posted" do
      @user1.postedResources.size.should == 2
    end
  end

  describe "#addComment" do
    it "should add a comment to a resource" do
      @user1.addComment(@resource1id, "This is my first comment!")
      Resource.find_by_id(@resource1id).comments.size.should == 1
    end
  end

  describe "#comments" do
    it "should return an array of comments by the user" do
      @user1.addComment(@resource1id, "This is a comment")
      @user1.addComment(@resource1id, "This is another comment")
      @user1.comments.size.should == 2
    end
  end

  describe "#flagResource" do
     it "Should be able to flag a valid Resource in the DB" do
	@user1.flagResource(@resource1id)
	Resource.find(@resource1id).flags.should eq(1)
     end
    
     it "Should not allow a Resource be flagged twice by same user" do
	@user1.flagResource(@resource1id)
	@user1.flagResource(@resource1id)
	Resource.find(@resource1id).flags.should eq(1)
     end     

  end
  
  describe "#addToFavorite" do
    it "should add the resource to the user's favorite" do
      @user1.addToFavorite(@resource1id)
      @user1.favorite.resources.size.should eq(1)
    end
  end

  describe "#deleteFavorite" do
    it "should delete the resource to the user's favorite" do
      @user1.addToFavorite(@resource1id)
      @user1.deleteFavorite(@resource1id)
      @user1.favorite.resources.size.should eq(0)
    end
  end


end
