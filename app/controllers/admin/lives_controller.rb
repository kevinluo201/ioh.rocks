class Admin::LivesController < ApplicationController
	before_action :authenticate_user!
	before_action :check_admin

	def index
		@lives = Live.all.includes(:live_school, :live_department, :live_times)
	end

	private
	def check_admin
		if current_user.regular?
			redirect login_path
		end
	end
end
