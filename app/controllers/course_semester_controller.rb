class CourseSemesterController < ApplicationController
    # Browse all courses
    # GET /course
    # GET /course.json
    def index
        # Check for filters

        respond_to do |format|
            format.html
            format.json {render json: @courses }
        end
    end

    # A particular course (not a particular semester class)
    # GET /course/id
    # GET /course/id.json
    def show

        respond_to do |format|
            format.html
            format.json {render json: @course }
        end
    end

end
