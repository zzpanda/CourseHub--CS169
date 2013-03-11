class CourseController < ApplicationController
    # Browse all courses
    # GET /courses/
    def index
        @courses = Course.all
        respond_to do |format|
            format.html
        end
    end

end
