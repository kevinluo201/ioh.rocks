class LiveTimesController < ApplicationController
	def index
		@times = LiveTime.all
	end

	def new
		@live_time = LiveTime.new
	end

	def create
		@live_time = LiveTime.new(time_params)

		if @live_time.save
			redirect_to live_times_path
		end
	end

	private
	def time_params
		params.require(:live_time).permit(:start)
	end
end
