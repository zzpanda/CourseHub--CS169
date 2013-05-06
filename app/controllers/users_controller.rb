class UsersController < ApplicationController

  # Home page for logged in user
  def home
    @page_title = "Home Page"

    @id = params[:id]
    if @id.nil? || @id == 0
      @id = current_user.id
    end

    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)

    @coursems = User.find(@id).subscribed
    @coursemids = []
    @coursems.each do |coursem|
      @coursemids << coursem.id
    end
    @event_strips = Event.event_strips_for_month(@shown_month, :conditions => {:coursem_id => @coursemids })

    @today = Date.current
    @ago = @today - 7.days
    @feed = Resource.where(:coursem_id => @coursemids).where("created_at > ?", @ago)

    @home = true

    #show favorite resources
    @favorites = current_user.favorite
    if @favorites.nil?
      @favorites = []
    else
      @favorites = @favorites.resources
    end
    @favorite = true
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

  def addFavorite
    if user_signed_in?

      @id = current_user.id
      @user = User.find(@id)
      @user.addToFavorite(params[:resource_id])
      render :json => {:status => 'success'}
    else

      render :json => {:status => 'user not signed in'}
    end
  end

  def deleteFavorite
    if user_signed_in?
      @id = current_user.id
      @user = User.find(@id)
      @user.deleteFavorite(params[:resource_id])
      render :json => {:status => 'success'}
    else
      render :json => {:status => 'user not signed in'}
    end
  end

  def show
    @user = User.find(params[:id])
    @coursems = @user.coursems
    @viewingProfile = true
    @resources = @user.resources
  end

  def coursems
    @user = current_user
    @page_title = "My Courses"
    @coursems = @user.coursems
  end
end
