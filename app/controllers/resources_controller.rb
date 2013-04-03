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

end
