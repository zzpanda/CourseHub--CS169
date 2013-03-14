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
      #Replace this with actual id derived from authentication scheme we're using
      @id = 1
    end
    @page_heading = "User Profile"
    @email = 'email@test.com'
    @karma = 1000
    @username = 'test user'

  end
end
