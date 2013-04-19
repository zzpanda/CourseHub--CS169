require 'spec_helper'

describe CalendarController do
  

  describe "GET index" do

    it "assigns @shown_month" do
      #Course.should_receive(:getCourseInformation).once.and_return([@course])
      get :index, :month => 10, :year => 2012
      assigns(:event_strips).should eq([[nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]])
    end

  end


end