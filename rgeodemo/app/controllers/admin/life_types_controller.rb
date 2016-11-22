class Admin::LifeTypesController < AdminController
	before_action :conditions, :new_object, only: [:index]

	def index
		@life_types = @q.result.order(:id).page(params[:page]).per(params[:limit])
	end

	def create
		@life_type = LifeType.create(permit_params(params))
		@life_type.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	def update
		@life_type = LifeType.find(params[:id])
		@life_type.update(permit_params(params))
		@life_type.errors.blank? ? success_message : fail_message
		respond_to do |format|
			format.js
		end
	end

	def destroy
		@life_type = LifeType.find(params[:id])
		@life_type.destroy
		@life_type.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	private

	def conditions
		@q = LifeType.ransack(params[:q])
	end

	def new_object
		@new_object = LifeType.new
	end

	def permit_params(params)
		params.require(:life_type).permit(:name, :description)
	end
end
