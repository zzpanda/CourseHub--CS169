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
    respond_to do |format|
      if @event.save
        #flash[:notice] = "Successfully created event"
        format.js {}
      else
        format.js {render :partial => 'error' }
      end
    end
  end

  def edit
    @event = Event.find(params[:id])
    @coursem = Coursem.find(@event.coursem_id)
    render :partial => 'form', :locals => {:event => @event}
  end

  def update
    @event = Event.find(params[:id])
    sdt = Event.datetimefromstrings(params[:event][:start_date], params[:event][:start_time])
    edt = Event.datetimefromstrings(params[:event][:end_date], params[:event][:end_time])
    @event.start_at = sdt
    @event.end_at = edt
    @event.name = params[:event][:name]
    @event.start_date =  params[:event][:start_date]
    @event.start_time =  params[:event][:start_time]
    @event.end_date =  params[:event][:end_date]
    @event.end_time =  params[:event][:end_time]
    @event.description =  params[:event][:description]

    respond_to do |format|
      if @event.save
        format.js
      else
        format.js { render :partial => 'error' }
      end
    end
  end

  #checks if an event has happened in the past n seconds
  def recentevent
    @event = Event.find(params[:id])
    @updated_at = @event.updated_at
    @recent = false;
    if @updated_at - 10.seconds.ago > 0
      @recent = true;
    end

    respond_to do |format|
      format.json { render :json => @recent }
    end

  end

end