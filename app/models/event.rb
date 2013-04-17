class Event < ActiveRecord::Base
  attr_accessible :name, :start_at, :end_at
  
  has_event_calendar
  belongs_to :coursem, :inverse_of => :events
end
