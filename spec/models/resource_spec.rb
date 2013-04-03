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

end
