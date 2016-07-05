class Api::LiveController < ApplicationController
	def index
		sort_by = params[:sort_by]

		case sort_by
		when "school"
			sort_by = "live_schools.name"
		when "department"
			sort_by = "live_departments.name"
		when "time"
			sort_by = "live_times.start"
		end
			
		@lives = Live.joins(:live_department, :live_school, :live_times)
							   .select("lives.id, lives.name, 
							   					live_departments.name as department, 
							   					live_schools.name as school,
							   					live_times.start as start,
							   					live_times.end as end")
							   .order(sort_by)

		respond_to do |format|
			format.json { render :json => @lives }
		end
	end
end
