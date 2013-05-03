require 'spec_helper'

describe Comment do

  before {@comment = Comment.new(content: "This is a comment!", user_id: 1, resource_id: 1)}

  subject {@comment}

  it {should respond_to(:content)}
  it {should respond_to(:user_id)}
  it {should respond_to(:resource_id)}

  #Tests for post_comment, delete_comment and like_comment functions

  it "Should be able to call post_comment to create comment" do
    comment = Comment.new
    comment.post_comment("first comment", 1, 1).should eq(1)
    Comment.find_by_content("first comment").content.should eq("first comment")
  end

  it "Should not be able to add comment with no user_id" do
    comment = Comment.new
    comment.post_comment("second comment").should eq(0)
    Comment.find_by_content("second comment").should eq(nil)

  end

  it "Should be able to delete comment that exists in DB" do
    comment = Comment.new
    comment.post_comment("third comment", 1, 1)
    id = Comment.find_by_content("third comment").id
    comment.delete_comment(id).should eq(1)
  end

  it "Should not be able to delete comment that doesnt exist in DB" do
    comment = Comment.new
    comment.delete_comment(1).should eq(0)
  end

  it "Should be able to like a comment that exists in DB" do
    comment = Comment.new
    comment.post_comment("fourth comment", 1, 1)
    id = Comment.find_by_content("fourth comment").id
    comment.like_comment(id,1).should eq(1)
  end

  it "Should not be able to like a comment that doesn't exist in DB" do
    comment = Comment.new
    comment.like_comment(1,1).should eq(0)
  end

end
