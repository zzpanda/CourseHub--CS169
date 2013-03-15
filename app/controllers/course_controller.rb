class CourseController < ApplicationController

  #different situations correspond to different errcodes
  #SUCCESS = 1
  #ERR_BAD_COURSE = -1

  # Browse all courses
  # GET /course
  # GET /course.json
  def index
      # Check for filters
      @courses = Course.getCourseInformation(params[:dept])
      @page_heading = "Browse Courses"
      @page_title = "Browse Courses"
      respond_to do |format|
          format.html
          format.json {render json: @courses }
      end
  end

  # A particular course (not a particular semester class)
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
        @page_title = "Browsing listing for " + @course.name + ": " + @course.course_info
        respond_to do |format|
          format.html
          format.json {render json: @course }
        end
      end
  end


end
