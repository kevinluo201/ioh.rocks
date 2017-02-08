class LivesController < ApplicationController
	layout "form"

	def new
		@schools = LiveSchool.order(:name)
		@departments = LiveDepartment.order(:name)
		@live_event = LiveEvent.active_event
		if @live_event && @live_event.signup_end > Time.now
			@live_times = @live_event.live_times
			@live = Live.new
		else
			render :over
		end
	end

	def create
		@live = Live.find_or_initialize_by(gmail: live_params['gmail'])
		@live.assign_attributes(live_params) if @live.new_record?
		@live.live_times = LiveTime.where(id: live_params['live_time_ids'])

		if @live.save
			flash[:success] = '報名成功！'
			redirect_to lives_success_path
		else
			flash[:alert] = @live.errors.full_messages.first
      redirect_to live_path
		end
	end

	def over
	end

	def success
		@live_event = LiveEvent.active_event
	end

	private

	def live_params
		params.require(:live).permit(:name, :gmail, :fb_url, :feedback, :school, :department,
																 :phone, :stream_201602, :location, :was_on_ioh,
																 { live_time_ids: [] })
	end
end
