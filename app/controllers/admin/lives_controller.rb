class Admin::LivesController < ApplicationController
	# before_action :authenticate_user!
	# before_action :check_admin

	def index
		@lives = Live.all.includes(:live_school, :live_department, :live_times)
										 .order(:created_at)

		if params[:query]
			@lives = Live.where("name LIKE ?", "%#{params[:query]}%")
									 .includes(:live_school, :live_department, :live_times)
									 .order(:created_at)
		end
	end

	def lh
		@lives = Live.all.includes(:live_school, :live_department, :live_times)
										 .order(:created_at)
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
																 :doc_naming, :stream_naming)
	end
end
