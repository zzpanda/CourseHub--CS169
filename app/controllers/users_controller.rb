class UsersController < ApplicationController
  def edit_profile
    respond_to do |format|
      @email = params[:email]
      @username = params[:username]
      format.all { render :json => {:status => 'email:' + @email+' username: ' + @username}, :content_type => 'application/json' }
    end
  end
  def test_user_id
    @email = 'email@test.com'
    @karma = 1000
    @username = 'test user'
    @user_id = '1'
  end
end
