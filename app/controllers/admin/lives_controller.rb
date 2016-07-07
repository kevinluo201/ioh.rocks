class Admin::LivesController < ApplicationController
	before_action :authenticate_user!
	before_action :check_admin

	def index
		@lives = Live.all.includes(:live_school, :live_department, :live_times)
	end

	def agenda
	end

	private
	def check_admin
		if current_user.regular?
			redirect_to new_user_session_path
		end
	end
end
