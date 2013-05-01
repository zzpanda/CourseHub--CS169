require 'json'
class ResourcesController < ApplicationController

  before_filter :authenticate_user!
  respond_to :json

  # Get all the possible department in the database
  def getResourcesType
    type = [Announcement, Discussion, DiscussionSolution, Exam, ExamSolution, Homework, HomeworkSolution, LectureNotes, OnlineResource, Other]
    dic = {:type => type}
    respond_to do |format|
      format.json {render json: dic}
    end
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def new
    @resource = Resource.new
    @coursem = Coursem.find(params[:coursem])
    @user = User.find(params[:user])
    render :partial => 'form', :locals => {:resource => @resource }
  end

  def create
    @resource = User.new.addResource(params[:resource][:name], params[:resource][:type], params[:resource][:link], params[:resource][:user_id], params[:resource][:coursem_id])
    @errCode = @resource
    if @resource.class != Fixnum
      @errCode = 1
    end
    @dic = {:errCode => @errCode, :resource => @resource}
    respond_to do |format|
      format.json { render json: @dic}
    end
  end

  #POST /resources/addComment
  def addComment
    @comments = params[:comment]
    @user_id = current_user.id
    @resource_id = params[:resource_id]
    @result = Comment.new.post_comment(@comments,@user_id, @resource_id)
    render json: {:errCode => @result}

  end

  def checkFavorite
    @favorite =  current_user.favorite
    @boolean = false
    if not @favorite.nil?
      @favoriteResource = @favorite.resources
      @favoriteResource.each do |resource|
        if resource.id.to_s == params[:resource_id]
          @boolean = true
        end
      end
    end
    respond_to do |format|
      format.json {render json: @boolean }
    end
  end

end
