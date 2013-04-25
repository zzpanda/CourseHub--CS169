class UsersController < ApplicationController

  def edit
    respond_to do |format|
      @email = params[:email]
      @username = params[:username]
      format.all { render :json => {:status => 'email:' + @email+' username: ' + @username}, :content_type => 'application/json' }
    end
  end

  def show
    @id = params[:id]
    if @id.nil? || @id == 0
      @id = current_user.id
    end
    @page_heading = "User Profile"
    @email = current_user.email
    @karma = 1000
    @username = 'test user'
    @coursems = User.find(@id).subscribed

    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)

    @coursemids = []
    @coursems.each do |coursem|
      @coursemids << coursem.id
    end
    @event_strips = Event.event_strips_for_month(@shown_month, :conditions => {:coursem_id => @coursemids })

  end

  def subscribe
    if user_signed_in?

      @id = current_user.id
      @user = User.find(@id)
      @user.subscribe(params[:coursem_id])
      render :json => {:status => 'success'}
    else

      render :json => {:status => 'user not signed in'}
    end
  end

  def unsubscribe
    if user_signed_in?
      @id = current_user.id
      @user = User.find(@id)
      @user.unsubscribe(params[:coursem_id])
      render :json => {:status => 'success'}
    else
      render :json => {:status => 'user not signed in'}
    end
  end
end
