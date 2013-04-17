require 'spec_helper'

describe Resource do

  before(:each) do
    @resource = Homework.new(name: "Example Resource", link: "http://exampleresource.com")
    @resourceId = @resource.id
  end

  subject {@resource}

  it {should respond_to(:name)}
  it {should respond_to(:link)}
  it {should respond_to(:coursem)}
  it {should respond_to(:user)}
  it {should respond_to(:comments)}
  it { should respond_to(:deleteResource) }

  # Unncessary method                                                                                                             .
  #describe ".id" do
  #  it "should return the resource id" do
  #    actualId = @resource.id
  #    Resource.id("Example Resource", "http://exampleresource.com").should equal(actualId)
  #  end
  #end

  describe "#comments" do
    it "should return an array of comment objects" do
      @user1 = User.create!(username: "Example User", email: "user@example.com", password: "aaaaaaaa")
      @user1.addComment(@resourceId, "This is a great resource!")
      @user1.addComment(@resourceId, "This is an excellent resource!")
      @resource.comments.size.should equal(2)
    end
  end

  describe "#deleteResource" do
    it "should return nil when trying to delete a non-existent Resource" do
      @user1 = User.create!(username: "Example User", email: "user@example.com", password: "aaaaaaaa")
      Resource.new.deleteResource(0).should == nil
    end

    it "should delete a resource that user posted and the corresponding comments to that resource" do
      @user1 = User.create!(username: "Example User", email: "user@example.com", password: "aaaaaaaa")
      Course.new.createAll("computer science","blabla","CS","169","Spring", 2013, "George")
      @coursem1 = Coursem.first
      @user1.addResource("Example Resource", "Homework", "http://ExampleResource.com", @user1.id, @coursem1.id)
      @resource1id = Resource.find_by_name_and_link("Example Resource", "http://ExampleResource.com").id
      Resource.new.deleteResource(@resource1id)
      Resource.find_by_id(@resource1id).should == nil
      Comment.all.size.should eq(0)
    end
  end
end
