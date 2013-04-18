class EventsController < ApplicationController

  def index
  end

  def show
    @event = Event.find(params[:id])
    render :partial => "event", :locals => {:event => @event}
  end

  def new
    @event = Event.new
    @coursem = Coursem.find(params[:coursem])
    render :partial => 'form', :locals => {:event => @event}
  end

  def create
    @event = Event.new(params[:event])
    sdt = Event.datetimefromstrings(params[:event][:start_date], params[:event][:start_time])
    edt = Event.datetimefromstrings(params[:event][:end_date], params[:event][:end_time])
    @event.start_at = sdt
    @event.end_at = edt
    #if sdt == nil
    #  @event.start_at = edt - 1.minute
    #end

    if @event.save
      #flash[:notice] = "Successfully created event"
      format.js {}
    else
      format.js {render :partial => 'error' }
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