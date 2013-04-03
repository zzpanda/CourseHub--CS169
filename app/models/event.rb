class Event < ActiveRecord::Base
  has_event_calendar

  attr_accessible :name, :start_at, :end_at

  belongs_to :coursem, :inverse_of => :coursems
end
