class CourseController < ApplicationController
    # Browse all courses
    # GET /course
    # GET /course.json
    def index
        # Check for filters
        @courses = Course.getCourseInformation(params[:dept])
        @page_heading = "Browse Courses"
        respond_to do |format|
            format.html
            format.json {render json: @courses }
        end
    end

    # A particular course (not a particular semester class)
    # GET /course/id
    # GET /course/id.json
    def show
        @course = Course.find(params[:id])
        @page_heading = @course.name
        respond_to do |format|
            format.html
            format.json {render json: @course }
        end
    end


end
