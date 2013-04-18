class ResourcesController < ApplicationController

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
    @resource = Resource.new(params[:resource])
    respond_to do |format|
      if @resource.save
        format.js {}
      else
        format.js {render :partial => 'error' }
      end
    end
  end

end
