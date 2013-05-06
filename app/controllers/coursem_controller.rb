class CoursemController < ApplicationController

  before_filter :authenticate_user!

  # Different situations correspond to different errcodes
  SUCCESS = 1
  BAD_NAME = -1
  BAD_DEPARTMENT = -2
  BAD_COURSE_NUMBER = -3
  ERR_BAD_COURSEM = -4
  BAD_TERM = -5
  BAD_YEAR = -6
  NO_SEMESTER_EXISTS = -7
  BAD_COURSEM_INFO = -8
  BAD_PROFESSOR = -9
  COURSEM_EXISTS = -10
  DEPARTMENT_NOT_CHOSEN = -11

  def new
    @coursem = Coursem.new
    @departments = Course.getDepartments
    @result = "<option>Please select below</option>"
    @departments.each do |department|
        @result += "<option>" + department + "</option>"
    end
    render :partial => "form"
  end

  # Create a new coursem
  # POST /coursem/create
  def create
    @coursem_info = "Unit:" + params[:unit] + " Course Description:" + params[:coursem_info]
    @coursem = Coursem.createCoursemByUser(params[:name], @coursem_info, params[:department], params[:course_number], params[:term], params[:year], params[:professor])
    @errCode = @coursem
    if @coursem.class != Fixnum
      @errCode = 1
    end
    @dic = {:errCode => @errCode, :coursem => @coursem}
    respond_to do |format|
      format.json { render json: @dic}
    end
  end


    # A particular semester class
    # GET /coursem/id
    # GET /coursem/id.json
    def show
      @coursem = Coursem.getCoursemInformation(params[:id])
      @user = current_user

      if @coursem.class == Fixnum
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
          format.xml  { head :not_found }
          format.any  { head :not_found }
        end
      else
        @c = @coursem.course;
        @page_title = @c.department + " " + @c.course_number + " : " + @c.name;

        @month = (params[:month] || (Time.zone || Time).now.month).to_i
        @year = (params[:year] || (Time.zone || Time).now.year).to_i
        @shown_month = Date.civil(@year, @month)
        @event_strips = @coursem.events.event_strips_for_month(@shown_month)

        @event = Event.new

        @today = Date.current
        @ago = @today - 7.days
        @feed = Resource.where("created_at > ? and coursem_id = ?", @ago, @coursem.id)

        if @user.subscribed?(@coursem)
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

  def resources
    @course = Course.find_by_id(params[:courseid])
    @coursemURL = "/coursem/" + params[:coursemid].to_s
  end

end
