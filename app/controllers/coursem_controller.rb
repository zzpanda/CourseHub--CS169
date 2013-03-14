class CoursemController < ApplicationController


    # A particular semester class
    # GET /coursem/id
    # GET /coursem/id.json
    def show
        @coursem = Coursem.getCoursems(params[:id])

        respond_to do |format|
            format.html
            format.json { render json: @coursem }
        end
    end
end
