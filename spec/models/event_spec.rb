require 'spec_helper'
require 'event'

describe Event do
  
  before(:each) do
  	yesterday = Date.current - 1.day
  	today = Date.current
  	t1 = Time.now
  	t2 = Time.now.midnight
  	sdt1 = Event.datetimefromobjects(today,t1)
  	edt1 = Event.datetimefromobjects(today,t2)
  	sdt2 = Event.datetimefromobjects(today,t1 - 24.hours)
  	edt2 = Event.datetimefromobjects(today,t2 - 24.hours)
  	@event1 = Event.create(:name=>"HW for Coursem 1",:start_date=>today,:end_date=>today, :start_time=>t1.strftime("%I:%M:%S %z"), :end_time=>t2.strftime("%I:%M:%S %z"), :start_at=>sdt1, :end_at=>edt1, :coursem_id => 1)
  	@event2 = Event.create(:name=>"HW for Coursem 3",:start_date=>yesterday,:end_date=>yesterday, :start_time=>t1.strftime("%I:%M:%S %z"), :end_time=>t2.strftime("%I:%M:%S %z"), :start_at=>sdt2, :end_at=>edt2, :coursem_id => 3)
  end

  it "should create correct event" do
  	@event = Event.find(1)
  	@event[:name].should eq("HW for Coursem 1")
  	@event[:start_date].should eq(Date.current)
  end

  it "should form object given date and time" do
  	Event.datetimefromobjects(Date.current, Time.now).year.should eq(DateTime.now.year)
  end

  it "should get year from string" do
  	Event.getyearfromstring("2013-01-01").should eq(2013)
  end
  
  it "should get month from string" do
  	Event.getmonthfromstring("2013-01-01").should eq(01)
  end

  it "should get day from string" do
  	Event.getdayfromstring("2013-01-01").should eq(01)
  end

  it "should get hour from string" do
    Event.gethourfromstring("22:23:04pm").should eq(10)
    Event.gethourfromstring("10:23:04am").should eq(10)
  end

  it "should get min from string" do
    Event.getminfromstring("22:23:04pm").should eq(23)
  end

  it "should get time from strings" do
    Event.datetimefromstrings("2013-01-01","22:23:04pm").should eq("Tue, 01 Jan 2013 10:23:00 +0000")
  end

end
