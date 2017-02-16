class Api::LiveController < ApplicationController
  URL = "http://ioh.rocks"
	before_action :authenticate_user!, :except => [:index, :onair, :basic_data, :live, :schedule, :update_stream]

	skip_before_filter :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def schedule
    appointments = LiveTimeAppointment.appointments_of_active_event.select(&:final_decision)
    data = appointments.map do |app|
              {
                name: app.live.name,
                channel: app.channel,
                time_id: app.live_time.id,
                school: app.live.school,
                department: app.live.department,
                user_id: app.live.id
              }
            end

  	render :json => data
  end

  def update_stream
  	data = params[:postData]

    # cancel all final_decision appointments
    LiveTimeAppointment.appointments_of_active_event.update_all(final_decision: false)

    data.each_value do |item|
      if item['name']
        live_id = Live.where(name: item['name']).first.id
        app = LiveTimeAppointment.where(live_time_id: item['time_id'].to_i,
                                        live_id: live_id).first
        app.channel = item['channel']
        app.final_decision = true
        app.save
      end
    end

  	render :json => { status: "success" }
  end

	# def admin
	# 	sort_by = params[:sort_by]

	# 	case sort_by
	# 	when "school"
	# 		sort_by = "live_schools.name"
	# 	when "department"
	# 		sort_by = "live_departments.name"
	# 	when "time"
	# 		sort_by = "live_times.start"
	# 	end

	# 	@lives = Live.joins(:live_department, :live_school)
	# 						   .select("lives.id, lives.title,
	# 						   					live_departments.name as department,
	# 						   					live_schools.name as school")
	# 						   .order(sort_by)

	# 	respond_to do |format|
	# 		format.json { render json: @lives.to_json(include: [:live_times]) }
	# 	end
	# end

	def index
		@live_event = LiveEvent.active_event
		data = []
		@live_event.live_times.each do |live_time|
			live_time.lives.each do |live|
				data_item = {}
				data_item[:title] = live.title
				data_item[:school] = live.school
				data_item[:department] = live.department
				data_item[:start] = live_time.start
				data_item[:end] = live_time.end
				data_item[:user_id] = live.id
				data_item[:time_id] = live_time.id

				data << data_item
			end
		end

		respond_to do |format|
			format.json { render json: data }
		end
	end

	# test if it is on air, if true return youtube_url
	def onair
		ioh_url = params[:ioh_url]

		# test onair
		onair = false

		if ioh_url
			live = Live.find_by_ioh_url(URI.escape(ioh_url))

			onair = live.onair
		end

		if live
			render json: { onair: onair, url: live.youtube_url, banner: live.banner_link }
		else
			render json: { onair: onair, message: "error!!" }
		end
	end

	def live
		order = params[:order]
    appointments = LiveTimeAppointment.appointments_of_active_event
                                      .select(&:final_decision)
                                      .sort { |a, b| a.live_time.start <=> b.live_time.start }
    data = appointments.map do |app|
              {
                name: app.live.name,
                channel: app.channel,
                school: app.live.school,
                department: app.live.department,
                start: app.live_time.start,
                link: app.live.ioh_url
              }
            end

		respond_to do |format|
			format.json { render json: data }
		end
	end

	def basic_data
		data = { school: [], department_one: [], department_two: [], time: [] }

		# get school
    LiveSchool.order(:name).each do |school|
      data[:school] << school.name
    end

		#get department 1
		LiveDepartment.where(dep_class: 1).order(:name).each do |dep|
      data[:department_one] << dep.name
    end

		#get department 2
		LiveDepartment.where(dep_class: 2).order(:name).each do |dep|
      data[:department_one] << dep.name
    end
		#get time
		times = LiveEvent.active_event.live_times.order(:start)

		times.each do |time|
			item = {}

			item[:time] = time.start
			item[:over] = Time.now > time.end
			data[:time].push item
		end

		respond_to do |format|
			format.json { render json: data }
		end
	end

  def past_lives
    lives = Live.inactive_lives.sort { |a, b| a.name <=> b.name }
    data = lives.map do |live|
              {
                name: live.name,
                school: live.school,
                department: live.department,
                link: live.ioh_url
              }
            end

    respond_to do |format|
      format.json { render json: data }
    end
  end

	def test
		@lives = Talk.all

		respond_to do |format|
			format.json { render json: @lives.to_json }
		end
	end

	def update_talk
		talk = params[:talk]

		if talk
			@talk = Talk.new
			@talk.title = talk[:title]
			@talk.post_name = talk[:name]
			@talk.live_school = LiveSchool.find talk[:school] unless talk[:school] == "NULL"
			@talk.live_department = LiveDepartment.find talk[:department]

			@talk.save
		end

		render plain: "good"
	end

	def update_school
		school = params[:school]

		if school
			@school = LiveSchool.new
			@school.name = school[:name]

			@school.save
		end

		render plain: "good"
	end

	def update_department
		department = params[:department]

		if department
			@department = LiveDepartment.new
			@department.name = department[:name]

			@department.save
		end

		render plain: "good"
	end

	private
	# For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, PATCH'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, PATCH'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
  end
end
