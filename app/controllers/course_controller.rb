class CourseController < ApplicationController
    # Browse all courses
    # GET /courses/
    def index
        # Check for filters
        @courses = Course.getCourseInformation(params[:dept])

        respond_to do |format|
            format.html
            format.json {render json: @courses }
        end
    end

    # A particular course (not a particular semester class)
    def show
        @course = Course.find(params[:id])
        respond_to do |format|
            format.html
        end
    end

    # A particular semester class (allows people to enroll)
    def semester_class

    end

end
