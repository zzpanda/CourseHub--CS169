class CoursemController < ApplicationController

    #different situations correspond to different errcodes
    ERR_BAD_COURSEM = -1
    #SUCCESS = 1

    # A particular semester class
    # GET /coursem/id
    # GET /coursem/id.json
    def show
      @coursem = Coursem.getCoursemInformation(params[:id])

      if @coursem == ERR_BAD_COURSEM
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
          format.xml  { head :not_found }
          format.any  { head :not_found }
        end
      else
        c = @coursem.course;
        @page_title = c.department + " " + c.course_number + " : " + c.name;
        @month = (params[:month] || (Time.zone || Time).now.month).to_i
        @year = (params[:year] || (Time.zone || Time).now.year).to_i
        @shown_month = Date.civil(@year, @month)
        @event_strips = @coursem.events.event_strips_for_month(@shown_month)
        respond_to do |format|
          format.html
          format.json { render json: @coursem }
        end
      end
    end

end
