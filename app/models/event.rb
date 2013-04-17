class Event < ActiveRecord::Base
  has_event_calendar

  attr_accessible :name, :start_date, :end_date, :start_time,:end_time, :start_at, :end_at, :description,:coursem_id

  belongs_to :coursem, :inverse_of => :events

  def self.createEvent(name, startdate, enddate, starttime, endtime, description, coursemid)
    startat = datetime(startdate, starttime)
    endat = datetime(enddate, endtime)
    Event.create!(:name=> name, :start_date=>startdate, :end_date=>enddate,:start_time=>starttime, :end_time=>endtime, :start_at=>startat, :end_at=>endat, :description=>description, :coursem_id=>coursemid)
  end

  def self.datetime(d,t)
    DateTime.new(getyear(d), getmonth(d), getday(d), gethour(t), getmin(t))
  end

  def self.getyear(date)
    d = date.split('-')
    d[0].to_i
  end
  def self.getmonth(date)
    d = date.split('-')
    d[1].to_i
  end
  def self.getday(date)
    d = date.split('-')
    d[2].to_i
  end

  def self.gethour(t)
    pm = true
    if t[t.length-2..-1] == "am"
      pm = false
    end
    t = t[0..t.length-3]
    t = t.split(":")
    if pm
        result = t[0].to_i + 12
        result.to_i
    else
      t[0].to_i
    end
  end

  def self.getmin(t)
    t = t[0..t.length-3]
    t = t.split(":")
    t[1].to_i
  end
end
