class LivesController < ApplicationController
	layout "form"

	def new
		@live = Live.new
	end

	def create
	end
end
