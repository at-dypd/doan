class Admin::PlantKingdomsController < AdminController
	before_action :conditions, :new_object, only: [:index]

	def index
		@plant_kingdoms = @q.result.order(:id).page(params[:page]).per(params[:limit])
	end

	def create
		@plant_kingdom = PlantKingdom.create(permit_params(params))
		@plant_kingdom.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	def update
		@plant_kingdom = PlantKingdom.find(params[:id])
		@plant_kingdom.update(permit_params(params))
		@plant_kingdom.errors.blank? ? success_message : fail_message
		respond_to do |format|
			format.js
		end
	end

	def destroy
		@plant_kingdom = PlantKingdom.find(params[:id])
		@plant_kingdom.destroy
		@plant_kingdom.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	private

	def conditions
		@q = PlantKingdom.ransack(params[:q])
	end

	def new_object
		@new_object = PlantKingdom.new
	end

	def permit_params(params)
		params.require(:plant_kingdom).permit(:name, :description)
	end
end
