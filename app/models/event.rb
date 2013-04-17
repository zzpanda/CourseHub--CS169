class Event < ActiveRecord::Base
  has_event_calendar

  attr_accessible :name, :start_date, :end_date, :start_time,:end_time, :start_at, :end_at, :description,:coursem_id

  belongs_to :coursem, :inverse_of => :events

  def self.createEvent(name, startdate, enddate, starttime, endtime, description, coursemid)
    startat = datetime(startdate, starttime)
    endat = datetime(enddate, endtime)
    Event.create!(:name=> name, :start_date=>startdate, :end_date=>enddate,:start_time=>starttime, :end_time=>endtime, :start_at=>startat, :end_at=>endat, :description=>description, :coursem_id=>coursemid)
  end

  def self.datetime(date, time)
    DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
  end
end
