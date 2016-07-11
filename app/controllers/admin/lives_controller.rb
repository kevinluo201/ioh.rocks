class Admin::LivesController < ApplicationController
	before_action :authenticate_user!
	before_action :check_admin

	def index
		@lives = Live.all.includes(:live_school, :live_department)
										 .order(:live_school_id, :created_at)

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
		day = params[:day]
		day ||= 1
		last_day = (17 + day.to_i).to_s
		day = (17 + day.to_i + 1).to_s

		date = Time.zone.parse("2016-07-" + day)
		last_date = Time.zone.parse("2016-07-" + last_day)

		@lives = Stream.where("streams.name IS NOT NULL")
								   .joins(:live, :live_time)
								   .where("live_times.start < ? AND live_times.start > ?", date, last_date)
								   .order("streams.live_host, live_times.start")
	end

	def cm
		day = params[:day]
		day ||= 1
		last_day = (17 + day.to_i).to_s
		day = (17 + day.to_i + 1).to_s

		date = Time.zone.parse("2016-07-" + day)
		last_date = Time.zone.parse("2016-07-" + last_day)

		@lives = Stream.where("streams.name IS NOT NULL")
								   .joins(:live, :live_time)
								   .where("live_times.start < ? AND live_times.start > ?", date, last_date)
								   .order("streams.live_host, live_times.start")
	end

	def cm_edit
		@live = Live.find params[:id]
	end

	def cm_update
		@live = Live.find params[:id]

		if @live.update_attributes(live_params)
			redirect_to admin_live_cm_view_path
		else
			render :cm_edit
			flash.now[:alert] = @live.errors.full_messages
		end
	end

	def edit
		@live = Live.find params[:id]
	end

	# lh stands for live host
	def lh_edit
		@live = Live.find params[:id]
	end

	def lh_update
		@live = Live.find params[:id]

		if @live.update_attributes(live_params)
			redirect_to admin_live_lh_view_path
		else
			render :lh_edit
			flash.now[:alert] = @live.errors.full_messages
		end
	end

	def follow_up
		day = params[:day]
		day ||= 1
		last_day = (17 + day.to_i).to_s
		day = (17 + day.to_i + 1).to_s

		date = Time.zone.parse("2016-07-" + day)
		last_date = Time.zone.parse("2016-07-" + last_day)

		# @lives = Live.joins(:live_times)
		# 					   .select("lives.*,
		# 					   					live_times.start as start,
		# 					   					live_times.end as end")
		# 					   .where("start < ? AND start > ?", date, last_date)
		# 					   .order("live_host, start")
		@lives = Stream.where("streams.name IS NOT NULL")
								   .joins(:live, :live_time)
								   .where("live_times.start < ? AND live_times.start > ?", date, last_date)
								   .order("streams.live_host, live_times.start")
	end

	def follow_up_edit
		@live = Live.find params[:id]
	end

	def follow_up_update
		@live = Live.find params[:id]

		if @live.update_attributes(live_params)
			redirect_to admin_live_follow_up_path
		else
			render :edit
			flash.now[:alert] = @live.errors.full_messages
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
	end

	def channel_edit
		@stream = Stream.find(params[:id])
	end

	def channel_update
		@stream = Stream.find params[:id]

		if @stream.update_attributes(stream_params)
			redirect_to admin_live_lh_view_path
		else
			render :edit
			flash.now[:alert] = @stream.errors.full_messages
		end
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
																 :chennal, :live_host, :audio_agree, :qa_link,
																 :doc_naming, :stream_naming, :youtube_url,
																 :test_record, :phone_contact, :ioh_url,
																 :banner_link, :move_to_part_3, :banner_status,
																 :embed_link_status, :no_show, :in_studio, :video_download,
																 :speaker_screenshot, :youtube_naming, :save_to_hard_drive,
																 :paste_survey_link,
																 :streams_attributes => [:chennal, :live_host])
	end

	def stream_params
		params.require(:stream).permit(:live_host, :chennal)
	end
end
