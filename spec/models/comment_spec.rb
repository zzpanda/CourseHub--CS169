require 'spec_helper'

describe Comment do

  before {@comment = Comment.new(content: "This is a comment!", user_id: 1, resource_id: 1)}

  subject {@comment}

  it {should respond_to(:content)}
  it {should respond_to(:user_id)}
  it {should respond_to(:resource_id)}



end
