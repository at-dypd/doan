class Admin::PlantPhylumsController < AdminController
	before_action :conditions, :new_object, only: [:index]

	def index
		@plant_phylums = @q.result.order(:id).page(params[:page]).per(params[:limit])
	end

	def create
		@plant_phylum = PlantPhylum.create(permit_params(params))
		@plant_phylum.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	def update
		@plant_phylum = PlantPhylum.find(params[:id])
		@plant_phylum.update(permit_params(params))
		@plant_phylum.errors.blank? ? success_message : fail_message
		respond_to do |format|
			format.js
		end
	end

	def destroy
		@plant_phylum = PlantPhylum.find(params[:id])
		@plant_phylum.destroy
		@plant_phylum.errors.blank? ? success_message : fail_message
		redirect_to :back
	end

	private

	def conditions
		@q = PlantPhylum.ransack(params[:q])
	end

	def new_object
		@new_object = PlantPhylum.new
	end

	def permit_params(params)
		params.require(:plant_phylum).permit(:name, :description)
	end
end
