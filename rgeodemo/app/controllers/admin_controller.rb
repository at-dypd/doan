class AdminController < ApplicationController
	before_action :load_limit
	layout "layouts/admin_application"
	before_action :authenticate_user!, :check_role
	def index
		
	end

	def load_limit
		params[:limit] ||= 10
	end

	def check_role
		unless current_user.role.name == "admin"
			flash[:danger] = "Lỗi truy cập"
			redirect_to root_path
		end
	end
end
