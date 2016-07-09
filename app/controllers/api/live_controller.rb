class Api::LiveController < ApplicationController
	before_action :authenticate_user!, :except => [:index, :onair]
	
	skip_before_filter :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

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
		lives = Live.joins(:live_department, :live_school, :live_times)
							   .select("lives.id as user_id, lives.title,
							   					live_departments.name as department,
							   					live_schools.name as school,
							   					live_times.start as start,
							   					live_times.end as end")

		data = []

		lives.each do |live|
			data_item = {}

			data_item[:title] = live.title
			data_item[:school] = /[\S]+$/.match(live.school)[0]
			data_item[:department] = /[\S]+$/.match(live.department)[0]
			data_item[:start] = live.start
			data_item[:end] = live.end
			data_item[:user_id] = live.user_id

			data.push data_item
		end

		respond_to do |format|
			format.json { render json: data }
		end
	end

	# test if it is on air, if true return youtube_url
	def onair
		ioh_url = params[:ioh_url]

		live = Live.find_by_ioh_url(URI.escape(ioh_url))

		# test onair
		onair = false

		live.live_times.each do |time|
			if Time.new >= time.start
				onair = true
			end
		end

		if onair
			render json: { onair: true, url: live.youtube_url }
		else
			render json: { onair: false, message: "error!!" }
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
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
  end
end
