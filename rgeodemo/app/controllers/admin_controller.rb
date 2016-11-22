class AdminController < ApplicationController
	before_action :load_limit
	layout "layouts/admin_application"
	def index
		
	end

	def load_limit
		params[:limit] ||= 10
	end
end
