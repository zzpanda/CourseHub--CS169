class CoursesController < ApplicationController

  # Browse all course
  # GET /course
  # GET /course.json
  def index
      # Check for filters
      @courses = Course.getCourseInformation(params[:dept],params[:course])
      @page_heading = "Browse Courses"
      @page_title = "Browse Courses"
      respond_to do |format|
          format.html
          format.json {render json: @courses }
      end
  end

  # Get all the possible department in the database
  # Return as a JSON object in the form
  # { 'department' => [ 'EE', 'CS', 'Math' ] }
  def getDepartment
    @dic = Course.getDepartments()
    respond_to do |format|
      format.json {render json: @dic}
    end
  end

  # A particular course (not a particular coursem)
  # GET /course/id
  # GET /course/id.json
  def show
      @course = Course.find_by_id(params[:id])
      if @course.nil?
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
          format.xml  { head :not_found }
          format.any  { head :not_found }
        end
      else
        @page_heading = @course.name
        #dirty addition of snazzy functionality. If anyone wants to clean up, welcome to.

        @page_title = "Browsing listing for " + @course.name
        respond_to do |format|
          format.html
          format.json {render json: @course }
        end
      end
  end


end
