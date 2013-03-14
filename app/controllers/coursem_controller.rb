class CoursemController < ApplicationController


    # A particular semester class
    # GET /coursem/id
    # GET /coursem/id.json
    def show
      @coursem = Coursem.getCoursemInformation(params[:id])
      if @coursem == -1
        dic = {:errCode => -1}
      else
        dic = {:errCode => 1, :cousem => @coursem}
      end
      respond_to do |format|
        format.html
        format.json { render json: dic }
      end
    end

end
