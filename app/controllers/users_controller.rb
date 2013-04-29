class UsersController < ApplicationController

  def edit
    respond_to do |format|
      @username = params[:username]
      logger.debug "fuckall"
      if User.find_by_username(@username).nil? || @username == current_user.username
        logger.debug "suckall"
        current_user.username = @username
        current_user.save!
        format.all { render :json => {:status => 'Change Successfully! Username: ' + @username}, :content_type => 'application/json' }
      else
        format.all { render :json => {:status => 'Username is already existed! Please try again.'}, :content_type => 'application/json' }
      end
    end
  end

  def show
    @id = params[:id]
    if @id.nil? || @id == 0
      @id = current_user.id
    end
    @page_heading = "User Profile"
    @email = current_user.email
    if current_user.karma == nil
      current_user.karma = 0
      current_user.save
    end
    @karma = current_user.karma
    @username = current_user.username
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
