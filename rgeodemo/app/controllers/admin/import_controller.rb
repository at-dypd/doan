class Admin::ImportController < AdminController

	def index
		
	end
	
	def import_medicinal_plant
		MedicinalPlant.import(params[:file])
		redirect_to :back
	end

	def import_location
		Location.import(params[:file])
		redirect_to :back
	end

	def import_medicinal_plants_locations
		MedicinalPlant.import_location(params[:file])
		redirect_to :back
	end
end
