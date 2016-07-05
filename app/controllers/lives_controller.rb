class LivesController < ApplicationController
	layout "form"

	def new
		@live = Live.new
	end

	def create
		@live = Live.new(live_params)

		if @live.save
      redirect_to lives_success_path
    else
			flash[:notice] = @live.errors
      render :new
    end
	end

	def success
	end

	def agenda
	end

	private
	def live_params
		params.require(:live).permit(:name, :gmail, :fb_url, 
																 :phone, :stream_201602, :location)
	end
end
