class Admin::LivesController < ApplicationController
	before_action :authenticate_user!
	before_action :check_admin

	def index
		@lives = Live.all.includes(:live_school, :live_department, :live_times)
	end

	private
	def check_admin
		unless current_user.admin?
			redirect login_path
		end
	end
end
