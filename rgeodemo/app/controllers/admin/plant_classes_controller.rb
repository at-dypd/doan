class Admin::PlantClassesController < AdminController
	before_action :conditions, :new_object, only: [:index]

	def index
		@plant_classes = @q.result.order(:id).page(params[:page]).per(params[:limit])
	end

	def create
		@plant_class = PlantClass.create(permit_params(params))
		@plant_class.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	def update
		@plant_class = PlantClass.find(params[:id])
		@plant_class.update(permit_params(params))
		@plant_class.errors.blank? ? success_message : fail_message
		respond_to do |format|
			format.js
		end
	end

	def destroy
		@plant_class = PlantClass.find(params[:id])
		@plant_class.destroy
		@plant_class.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	private

	def conditions
		@q = PlantClass.ransack(params[:q])
	end

	def new_object
		@new_object = PlantClass.new
	end

	def permit_params(params)
		params.require(:plant_class).permit(:name, :description)
	end
end
