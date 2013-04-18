class CoursemController < ApplicationController

    # Different situations correspond to different errcodes
    SUCCESS = 1
    ERR_BAD_COURSEM = -1

    def create
       @new = Coursem.createCoursemByUser(params[:name], params[:coursem_info], params[:department], params[:course_number], params[:term], params[:year], params[:professor])
       respond_to do |format|
         format.html
         format.json { render json: @new }
       end
    end


    # A particular semester class
    # GET /coursem/id
    # GET /coursem/id.json
    def show
      @coursem = Coursem.getCoursemInformation(params[:id])
      @user = current_user

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

        @event = Event.new

        if current_user.subscribed?(@coursem)
          @subscribe_text = "Unsubscribe"
          @subscribed = 1
        else
          @subscribe_text = "Subscribe"
          @subscribed = 0
        end
        respond_to do |format|
          format.html
          format.json { render json: @coursem }
        end
      end
    end

    def createEvent

    end



end
