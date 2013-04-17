class EventsController < ApplicationController

  def load
    @events = Event.all
    @events = Event.new
  end

  def index
  end

  def create
    @event = Event.new(params[:event])
    sdt = Event.datetime(params[:event][:start_date], params[:event][:start_time])
    edt = Event.datetime(params[:event][:end_date], params[:event][:end_time])
    @event.start_at = sdt
    @event.end_at = edt
    if @event.save
      #flash[:notice] = "Successfully created event"
      @events = Event.all
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = "Succesfully updated event"
      @events = Event.all
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Succesfully destroyed post."
    @events = Event.all
  end

end