class Api::LiveController < ApplicationController
	# def admin
	# 	sort_by = params[:sort_by]

	# 	case sort_by
	# 	when "school"
	# 		sort_by = "live_schools.name"
	# 	when "department"
	# 		sort_by = "live_departments.name"
	# 	when "time"
	# 		sort_by = "live_times.start"
	# 	end
			
	# 	@lives = Live.joins(:live_department, :live_school)
	# 						   .select("lives.id, lives.title, 
	# 						   					live_departments.name as department, 
	# 						   					live_schools.name as school")
	# 						   .order(sort_by)

	# 	respond_to do |format|
	# 		format.json { render json: @lives.to_json(include: [:live_times]) }
	# 	end
	# end

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
							   .select("lives.id, lives.title, 
							   					live_departments.name as department, 
							   					live_schools.name as school,
							   					live_times.start as start,
							   					live_times.end as end")
							   .order(sort_by)

		respond_to do |format|
			format.json { render json: @lives.to_json }
		end
	end

	def test
		@lives = LiveDepartment.all

		respond_to do |format|
			format.json { render json: @lives.to_json }
		end
	end

	def update
		talk = params[:talk]

		if talk
			@talk = Talk.new
			@talk.title = talk[:title]
			@talk.post_name = talk[:name]
			@talk.live_school = LiveSchool.find talk[:school] unless talk[:school] == "NULL"
			@talk.live_department = LiveDepartment.find talk[:department]

			@talk.save
		end

		render plain: "good"
	end
end
