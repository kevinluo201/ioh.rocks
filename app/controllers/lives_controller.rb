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

		talk = Talk.where("title like ? ", "%#{@live.name}%").first

		if talk
			@live.live_school_id = talk.live_school_id
			@live.live_department_id = talk.live_department_id
			@live.ioh_url = "https://ioh.tw/talks/#{talk.post_name}"
		end

		if @live.valid? && talk
			@live.save
			@live.time_count = @live.live_times.count
			@live.save
      redirect_to lives_success_path
    elsif talk.nil?
    	flash.now[:alert] = "名字輸入錯誤"

    	render :new
    else
			flash.now[:alert] = @live.errors.full_messages.first

      render :new
    end
	end

	def over
	end

	def success
	end

	private
	def live_params
		params.require(:live).permit(:name, :gmail, :fb_url, :feedback, :school, :department,
																 :phone, :stream_201602, :location, { live_time_ids: [] })
	end
end
