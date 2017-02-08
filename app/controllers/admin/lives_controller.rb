class Admin::LivesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :active_event, only: [:index, :new, :lh, :cm, :follow_up, :agenda]

  def new_school
  end

  def create_school
    @school = LiveSchool.new(school_params)

    if @school.save
      redirect_to admin_live_school_path
    else
      render :plain => "gg"
    end
  end

  def school_params
    params.require(:school).permit(:name)
  end

  def new_department
  end

  def create_department
    @department = LiveDepartment.new(department_params)

    if @department.save
      redirect_to admin_live_department_path
    else
      render :plain => "gg"
    end
  end

  def department_params
    params.require(:department).permit(:name)
  end

  def index
    @lives = Live.active_lives

    if params[:query]
      @lives = Live.where("name LIKE ?", "%#{params[:query]}%")
      .includes(:live_school, :live_department)
      .order(:time_count)
    end
  end

  def new
    @live = Live.new
  end

  def create
    @live = Live.new(live_params)

    if @live.save
      @live.time_count = @live.live_times.count
      @live.save
      redirect_to admin_live_view_path
    else
      render :new
      flash.now[:alert] = @live.errors.full_messages
    end
  end

  def lh
    day = params[:day] || '0'

    @appointments = active_appointments

    if day != '0'
      date = LiveEvent.active_event.period.map {|x| x }[day.to_i - 1]
      @appointments.select! { |x| x.live_time.start.to_date == date }
    end

    @streams = @appointments.map { |a| a.stream }
  end

  def cm
    day = params[:day] || '0'

    @appointments = active_appointments

    if day != '0'
      date = LiveEvent.active_event.period.map {|x| x }[day.to_i - 1]
      @appointments.select! { |x| x.live_time.start.to_date == date }
    end

    @streams = @appointments.map { |a| a.stream }
  end

  def cm_edit
    @stream = Stream.find params[:id]
  end

  def cm_update
    @stream = Stream.find params[:id]

    if @stream.update_attributes(stream_params)
      redirect_to admin_live_cm_view_path
    else
      render :cm_edit
      flash.now[:alert] = @stream.errors.full_messages
    end
  end

  def edit
    @live = Live.find params[:id]
    @live_event = LiveEvent.active_event
  end

  # lh stands for live host
  def lh_edit
    @stream = Stream.find params[:id]
  end

  def lh_update
    @stream = Stream.find params[:id]

    if @stream.update_attributes(stream_params)
      redirect_to admin_live_lh_view_path
    else
      render :lh_edit
      flash.now[:alert] = @stream.errors.full_messages
    end
  end

  def follow_up
    day = params[:day] || '0'

    @appointments = active_appointments

    if day != '0'
      date = LiveEvent.active_event.period.map {|x| x }[day.to_i - 1]
      @appointments.select! { |x| x.live_time.start.to_date == date }
    end

    @streams = @appointments.map { |a| a.stream }
  end

  def follow_up_edit
    @stream = Stream.find params[:id]
  end

  def follow_up_update
    @stream = Stream.find params[:id]

    if @stream.update_attributes(stream_params)
      redirect_to admin_live_follow_up_path
    else
      render :edit
      flash.now[:alert] = @stream.errors.full_messages
    end
  end

  def update
    @live = Live.find params[:id]

    if @live.update_attributes(live_params)
      redirect_to admin_live_view_path
    else
      render :edit
      flash.now[:alert] = @live.errors.full_messages
    end
  end

  def destroy
    @live = Live.find params[:id]
    @live.destroy

    redirect_to admin_live_view_path
  end

  def agenda
      # classify the LiveTime by time then sort by date
      # this is for presenting in table's row
      @live_times_array = @live_event.live_times_for_agenda
  end

  private
  def check_admin
    if current_user.regular?
      redirect_to new_user_session_path
    end
  end

  def live_params
    params.require(:live).permit(:name, :gmail, :fb_url, :feedback, :school, :department,
                                 :phone, :stream_201602, :location, { live_time_ids: [] },
                                 :live_school_id, :live_department_id,
                                 :ioh_url, :banner_link)
  end

  def stream_params
    params.require(:stream).permit(:live_host,
                                   :audio_agree, :qa_link,
                                   :doc_naming, :stream_naming, :youtube_url,
                                   :test_record, :phone_contact,
                                   :move_to_part_3, :banner_status,
                                   :embed_link_status, :no_show, :in_studio, :video_download,
                                   :speaker_screenshot, :youtube_naming, :save_to_hard_drive,
                                   :paste_survey_link)
  end

  def active_event
    @live_event = LiveEvent.active_event
    if @live_event
      @live_event
    else
      flash[:alert] = '目前沒有舉行中的直播活動'
      redirect_to admin_live_events_path
    end
  end

  def active_appointments
    LiveTimeAppointment.appointments_of_active_event.joins(:stream)
                       .order('streams.live_host, live_times.start')
                       .select(&:final_decision)
  end
end
