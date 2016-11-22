class UserMedicinalPlantsController < ApplicationController
	before_action :get_medicinal_plant, :get_search_condition, only: [:show]
	before_action :init_data

	def show
		@medicinal_plants = @q.result.includes(:locations).order(:name)
		@object_index = @medicinal_plants.find_index(@medicinal_plant)
		@previous_plant = @medicinal_plants[@object_index - 1] if @object_index > 0
		@next_plant = @medicinal_plants[@object_index + 1] if @object_index < @medicinal_plants.length
		locations = @medicinal_plant.locations.flatten.uniq
		gon.locations = locations.collect{|c| [c.latlon.x, c.latlon.y]}
	end

	def detail
		point = Location.convert_to_point(params[:lat], params[:lon])
		@medicinal_plants = MedicinalPlant.includes(:locations).where(locations: {latlon: point})
		@medicinal_plant = @medicinal_plants.first
		respond_to do |format|
			format.js
		end
	end

	def update
		
	end

	private

	def get_medicinal_plant
		id = params[:object_id].present? ? params[:object_id] : params[:id] 
		@medicinal_plant = MedicinalPlant.find(id)
	end

	def get_search_condition
		@q = MedicinalPlant.ransack(params[:q])
	end

	def init_data
		@used_parts = UsedPart.all.order(:name)
    @plant_habitats = PlantHabitat.all.order(:name)
    @plant_orders = PlantOrder.all.order(:name)
    @plant_classes = PlantClass.all.order(:name)
    @plant_kingdoms = PlantKingdom.all.order(:name)
    @plant_phylums = PlantPhylum.all.order(:name)
	end
end
