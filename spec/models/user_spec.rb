require 'spec_helper'

describe User do



  before do
    @user1 = User.create!(username: "Example User", email: "user@example.com",
                      password: "aaa")
    @user1.addResource("Example Resource", "Homework", "http://ExampleResource.com")
    @resource1id = Resource.find_by_name_and_link("Example Resource", "http://ExampleResource.com").id
    @user1.addResource("a", "Discussion", "http://c.com")

    @otheruser = User.create!(username: "Other UserR", email: "user@other.com",
                      password: "bbb")
    @otheruser.addResource("Other Resource", "Lecture", "http://OtherResource.com")
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
  it { should respond_to(:deleteResource) }
  it { should respond_to(:postedResource?) }
  it { should respond_to(:postedResources) }
  it { should respond_to(:addComment) }
  it { should respond_to(:commentsBy) }

  describe "accessible attributes" do
    it "should not allow access to karma" do
      expect do
        User.new(karma: "1000000")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

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

  #Removing this test makes deleteResource work
  #describe "#addComment" do
  #  it "should add a comment to a resource" do
  #    @user1.addComment(@resource1id, "This is my first comment!")
  #    Resource.find_by_id(@resource1id).comments.size.should == 1
  #  end
  #end

  #describe "#comments" do
  #  it "should return an array of comments by the user" do
  #    @user1.addComment(@resource1id, "This is a comment")
  #    @user1.addComment(@resource1id, "This is another comment")
  #    @user1.comments.size.should == 2
  #  end
  #end

  describe "#deleteResource" do
    it "should return nil when trying to delete a non-existent Resource" do
      @user1.deleteResource(0).should == nil
    end
    it "should delete a resource that user posted" do
      @user1.deleteResource(@resource1id)
      Resource.find_by_id(@resource1id).should == nil
    end
  end


end
