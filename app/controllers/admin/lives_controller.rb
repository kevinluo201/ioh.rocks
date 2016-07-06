class Admin::LivesController < ApplicationController
	def index
		@lives = Live.all.includes(:live_school, :live_department, :live_times)
	end
end
