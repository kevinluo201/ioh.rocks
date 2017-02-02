class LivesController < ApplicationController
	layout "form"

	def new
		@live_event = LiveEvent.where(active: true).first
		if @live_event && @live_event.signup_end > Time.now
			@live_times = @live_event.live_times
			@live = Live.new
		else
			render :over
		end
	end

	def create
		@live = Live.new(live_params)
		@live.live_times = LiveTime.where(id: live_params['live_time_ids'])

		if @live.save
			redirect_to lives_success_path
		else
			flash.now[:alert] = @live.errors.full_messages.first
      render :new
		end
	end

	def over
	end

	def success
		@live_event = LiveEvent.where(active: true).first
	end

	private
	def live_params
		params.require(:live).permit(:name, :gmail, :fb_url, :feedback, :school, :department,
																 :phone, :stream_201602, :location, { live_time_ids: [] })
	end
end
