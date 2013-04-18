class Event < ActiveRecord::Base
  has_event_calendar

  attr_accessible :name, :start_date, :end_date, :start_time,:end_time, :start_at, :end_at, :description,:coursem_id

  belongs_to :coursem, :inverse_of => :events

  def self.createEvent(name, startdate, enddate, starttime, endtime, description, coursemid)
    startat = datetime(startdate, starttime)
    endat = datetime(enddate, endtime)
    Event.create!(:name=> name, :start_date=>startdate, :end_date=>enddate,:start_time=>starttime, :end_time=>endtime, :start_at=>startat, :end_at=>endat, :description=>description, :coursem_id=>coursemid)
  end

  ##############################
  def self.datetimefromobjects(d,t)
    DateTime.new(d.year, d.month, d.day, t.hour, t.min)
  end

  ##############################
  def self.datetimefromstrings(d,t)
    DateTime.new(getyearfromstring(d), getmonthfromstring(d), getdayfromstring(d), gethourfromstring(t), getminfromstring(t))
  end

  def self.getyearfromstring(date)
    d = date.split('-')
    d[0].to_i
  end
  def self.getmonthfromstring(date)
    d = date.split('-')
    d[1].to_i
  end
  def self.getdayfromstring(date)
    d = date.split('-')
    d[2].to_i
  end

  def self.gethourfromstring(t)
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
  def self.getminfromstring(t)
    t = t[0..t.length-3]
    t = t.split(":")
    t[1].to_i
  end

end
