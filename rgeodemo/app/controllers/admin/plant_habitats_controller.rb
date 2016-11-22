class Admin::PlantHabitatsController < AdminController
	before_action :conditions, :new_object, only: [:index]

	def index
		@plant_habitats = @q.result.order(:id).page(params[:page]).per(params[:limit])
	end

	def create
		@plant_habitat = PlantHabitat.create(permit_params(params))
		@plant_habitat.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	def update
		@plant_habitat = PlantHabitat.find(params[:id])
		@plant_habitat.update(permit_params(params))
		@plant_habitat.errors.blank? ? success_message : fail_message
		respond_to do |format|
			format.js
		end
	end

	def destroy
		@plant_habitat = PlantHabitat.find(params[:id])
		@plant_habitat.destroy
		@plant_habitat.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	private

	def conditions
		@q = PlantHabitat.ransack(params[:q])
	end

	def new_object
		@new_object = PlantHabitat.new
	end

	def permit_params(params)
		params.require(:plant_habitat).permit(:name, :description)
	end
end
