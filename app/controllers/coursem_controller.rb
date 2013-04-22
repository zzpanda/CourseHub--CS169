class CoursemController < ApplicationController

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
    #Rails.logger.info "My info message#{@coursem}"
    @departments = Course.getDepartments
    @result = "<option>Please select below</option>"
    @departments.each do |department|
        @result += "<option>" + department + "</option>"
    end
    render :partial => "form", :locals => {:name => "", :unit => "", :course_number => "", :coursem_info => "", :professor => "", :year => "", :result => @result }
  end

  # Create a new coursem
  # POST /coursem/create
  def create
    if params[:unit] != nil and params[:coursem_info] != nil
      @coursem_info = "Unit:" + params[:unit] + " Course Description:" + params[:coursem_info]
    end
    @coursem = Coursem.createCoursemByUser(params[:name], @coursem_info, params[:department], params[:course_number], params[:term], params[:year], params[:professor])
    #Rails.logger.info "My info message#{@coursem}"
    #Rails.logger.info "My info message#{@errMessage}"
    if @coursem.class == Fixnum
      if @coursem == BAD_NAME
        @errMessage = "The name shouldn't be empty or a number. Please try again. "
      elsif @coursem == BAD_DEPARTMENT
        @errMessage =  "The department shouldn't be empty or a number. Please try again."
      elsif @coursem == BAD_COURSE_NUMBER
        @errMessage = "The course number shouldn't be empty. Please try again."
      elsif @coursem == BAD_TERM
        @errMessage = "The term shouldn't be empty or a number. Please try again."
      elsif @coursem == BAD_YEAR
        @errMessage = "The year shouldn't be empty or a test. Please try again."
      elsif @coursem == NO_SEMESTER_EXISTS
        @errMessage = "The semester is not exist. Please try again."
      elsif @coursem == BAD_COURSEM_INFO
        @errMessage = "The course information shouldn't be empty. Please try again."
      elsif @coursem == BAD_PROFESSOR
        @errMessage = "The professor shouldn't be empty or a number. Please try again."
      elsif @coursem == COURSEM_EXISTS
        @errMessage = "The course is already existed. Please try again."
      elsif @coursem == DEPARTMENT_NOT_CHOSEN
        @errMessage = "The department is not chosen. Please try again."
      else
        @errMessage = "Unknown error occured: " + @coursem
      end

      @departments = Course.getDepartments
      @result = "<option>Please select below</option>"
      @departments.each do |department|
        @result += "<option>" + department + "</option>"
      end

      respond_to do |format|
        format.html { render :partial => "form", :locals => {:result => @result, :name => params[:name], :unit => params[:unit], :course_number => params[:course_number], :coursem_info => params[:coursem_info], :professor => params[:professor], :year => params[:year]} }
      end

    else
      redirect_to @coursem
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
        @c = @coursem.course;
        @page_title = @c.department + " " + @c.course_number + " : " + @c.name;

        @month = (params[:month] || (Time.zone || Time).now.month).to_i
        @year = (params[:year] || (Time.zone || Time).now.year).to_i
        @shown_month = Date.civil(@year, @month)
        @event_strips = @coursem.events.event_strips_for_month(@shown_month)

        @event = Event.new

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

    def createEvent

    end



end
