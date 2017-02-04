class Api::LiveController < ApplicationController
  URL = "http://ioh.rocks"
	before_action :authenticate_user!, :except => [:index, :onair, :basic_data, :live, :schedule, :update_stream]

	skip_before_filter :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def schedule
  	streams = Stream.all.select("name, chennal as channel, live_time_id as time_id, live_id")
  									.order("time_id")

  	data = []
  	streams.each do |stream|
  		item = {}
  		item['name'] = stream.name
  		item['channel'] = stream.channel
  		item['time_id'] = stream.time_id
  		item['school'] = stream.live.school if stream.live
  		item['department'] = stream.live.department if stream.live
      item['user_id'] = stream.live.id if stream.live

  		data.push item
  	end

  	render :json => data
  end

  def update_stream
  	data = params[:postData]

  	# delete all data
  	Stream.delete_all

  	# Stream.connection.execute('ALTER TABLE `streams` AUTO_INCREMENT = 1;')
  	data.each_value do |item|
  		stream = Stream.new

  		stream.name = item['name'] if item['name']
  		stream.chennal = item['channel']
  		stream.live_time = LiveTime.find(item['time_id'].to_i)
  		stream.live = Live.find_by_name(stream.name)

  		stream.save
  	end

  	# if Stream.first.nil?
	  # 	data.each_value do |item|
	  # 		stream = Stream.new

	  # 		stream.name = item['name'] if item['name']
	  # 		stream.chennal = item['channel']
	  # 		stream.live_time = LiveTime.find(item['time_id'].to_i)
	  # 		stream.live = Live.find_by_name(stream.name)

	  # 		stream.save
	  # 	end
  	# else
  	# 	data.each_value do |item|
	  # 		stream = Stream.where("chennal = ? AND live_time_id = ?", item['channel'], item['time_id'].to_i).first

	  # 		stream.name = item['name']
	  # 		stream.live = Live.find_by_name(stream.name)

	  # 		stream.save
	  # 	end
  	# end


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

		# data = []

		# lives.each do |live|
		# 	data_item = {}

		# 	data_item[:title] = live.title
		# 	data_item[:school] = /[\S]+$/.match(live.school)[0]
		# 	data_item[:department] = /[\S]+$/.match(live.department)[0]
		# 	data_item[:start] = live.start
		# 	data_item[:end] = live.end
		# 	data_item[:user_id] = live.user_id
		# 	data_item[:time_id] = live.time_id

		# 	data.push data_item
		# end

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
		data = []

		# lives = Live.joins(:live_department, :live_school, :live_times)
		# 				    .select("lives.name, lives.ioh_url,
		# 				   					 live_departments.name as department,
		# 				   					 live_schools.name as school,
		# 				   					 live_times.start as start,
		# 				   					 live_times.end as end")
		# 				    .order("start, school")

		streams = Stream.joins(:live_time, :live)
		              .select("streams.name,
		              				 streams.live_id,
		              				 live_times.start as start")
		              .order("start")

		streams.each do |stream|
			data_item = {}

			data_item[:name] = stream.name
			data_item[:school] = stream.live.school
			data_item[:department] = stream.live.department
			data_item[:start] = stream.start
			data_item[:link] = stream.live.ioh_url

			data.push data_item
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
