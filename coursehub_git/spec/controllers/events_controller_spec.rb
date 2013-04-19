require 'spec_helper'

describe EventsController do
  describe "GET show" do
    before do
      @event = mock_model(Event)
      Event.stub!(:find).with("1").and_return(@event)
    end

    it "should find an event and return it" do
      Event.should_receive(:find).with("1").and_return(@event)
      get :show, :id => "1", :event => {}
    end

    it "should render the event partial" do
      get :show, :id => "1", :event => {}
      response.should render_template('event')
    end
  end

  describe "GET new" do
    before do
      @event = mock_model(Event)
      @coursem = mock_model(Coursem)
      Coursem.stub!(:find).with("1").and_return(@coursem)
      Event.stub!(:new).and_return(@event)
    end

    it "should create a new event" do
      Event.should_receive(:new).and_return(@event)
      get :new, :coursem => "1"
    end

    it "should find the coursem for the event" do
      Coursem.should_receive(:find).with("1").and_return(@coursem)
      get :new, :coursem => "1"
    end

    it "should render the event form" do
      get :new, :coursem => "1"
      response.should render_template('form')
    end
  end

  describe "POST create" do
    before do
      @datetime = mock(DateTime)
      Event.stub!(:datetimefromstrings).and_return(@datetime)
      @event = mock_model(Event, :save => true, :start_at= => @datetime, :end_at= => @datetime)
      Event.stub!(:new).and_return(@event)
    end

    it "should create a new Event" do
      Event.should_receive(:new).and_return(@event)
      get :create, :event => {}
    end

    it "should call Event.datetime" do
      Event.should_receive(:datetimefromstrings).and_return(@datetime)
      get :create, :event => {}
    end

    it "should set the event's start_at and end_at fields" do
      @event.should_receive(:start_at=).and_return(@datetime)
      @event.should_receive(:end_at=).and_return(@datetime)
      get :create, :event => {}
    end

    it "should save the event" do
      @event.should_receive(:save).and_return(true)
      get :create, :event => {}
    end
  end

  describe "GET edit" do
    before do
      @event = mock_model(Event, :coursem_id => "1")
      Event.stub!(:find).with("1").and_return(@event)
      @coursem = mock_model(Coursem)
      Coursem.stub!(:find).with("1").and_return(@coursem)
    end

    it "should find the event" do
      Event.should_receive(:find).with("1").and_return(@event)
      get :edit, :id => "1"
    end

    it "should find the coursem for the event" do
      Coursem.should_receive(:find).with("1").and_return(@coursem)
      get :edit, :id => "1"
    end

    it "should render the event form" do
      get :edit, :id => "1"
      response.should render_template('form')
    end
  end

  describe "PUT update" do
    before do
      @datetime = mock(DateTime)
      Event.stub!(:datetimefromstrings).and_return(@datetime)
      @event = mock_model(Event, :start_at= => @datetime, :end_at= => @datetime, :name= => "Party",
                      :start_date= => "1", :start_time= => "2", :end_date= => "3", :end_time= => "4",
                      :description= => "Fun", :save => true)
      Event.stub!(:find).with("1").and_return(@event)
    end

    it "should find the event" do
      Event.should_receive(:find).with("1").and_return(@event)
      put :update, :id => "1", :event => {}
    end

    it "should call Event.datetime" do
      Event.should_receive(:datetimefromstrings).and_return(@datetime)
      put :update, :id => "1", :event => {}
    end

    it "should set all the fields" do
      @event.should_receive(:start_at=).and_return(@datetime)
      @event.should_receive(:end_at=).and_return(@datetime)
      @event.should_receive(:name=).and_return("Party")
      @event.should_receive(:start_date=).and_return("1")
      @event.should_receive(:start_time=).and_return("2")
      @event.should_receive(:end_date=).and_return("3")
      @event.should_receive(:end_time=).and_return("4")
      @event.should_receive(:description=).and_return("Fun")
      @event.should_receive(:save).and_return(true)
      put :update, :id => "1", :event => {}
    end

    it "should save the event" do
      @event.should_receive(:save).and_return(true)
      put :update, :id => "1", :event => {}
    end
  end

  describe "recentevent" do
    before do
      @ago = Time.new
      @event = mock_model(Event, :updated_at => @ago)
      Event.stub!(:find).with("1").and_return(@event)
    end

    it "should if the event was updated recently" do
      @event.should_receive(:updated_at).and_return(@ago)
      diff = @event.updated_at - 3600.seconds.ago
      recent = diff > 0
      recent.should == true
      get :recentevent, :id => "1"
    end

    it "should render a json" do
      get :recentevent, :id => "1"
      response.body.should == { } # have to fix this
    end
  end

end
