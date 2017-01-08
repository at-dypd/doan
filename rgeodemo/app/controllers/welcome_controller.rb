class WelcomeController < ApplicationController
	before_action :get_search_condition, :init_data

	def index
		@medicinal_plants = @q.result.includes(:locations, :used_parts, :plant_habitats,
                                           :life_type, :plant_phylum, :plant_class,
                                           :plant_order, :plant_kingdom).order(:name)
		locations = @medicinal_plants.map(&:locations).flatten.uniq
		@medicinal_plant = @medicinal_plants.first
		gon.locations = locations.collect{|c| [c.latlon.x, c.latlon.y]}
    gon.q = params[:q]
	end

	private

	def get_search_condition
    params[:q] ||= {}
    params[:q][:id_in] ||= params[:ids]
    if params[:polygon_points].present?
      latlons = Location.convert_latlon(params[:polygon_points].split(",").in_groups_of(2))      
      params[:q][:locations_latlon_in] = latlons
      @q = MedicinalPlant.ransack(params[:q])
    elsif params[:circle_points].present?
      latlons = Location.convert_latlon(params[:circle_points].split(",").in_groups_of(2))
      params[:q][:locations_latlon_in] = latlons
      @q = MedicinalPlant.ransack(params[:q])
    else
      @q = MedicinalPlant.ransack(params[:q])
    end
  end

  def init_data
  	@used_parts = UsedPart.all.order(:name)
    @plant_habitats = PlantHabitat.all.order(:name)
    @plant_orders = PlantOrder.all.order(:name)
    @plant_classes = PlantClass.all.order(:name)
    @plant_kingdoms = PlantKingdom.all.order(:name)
    @plant_phylums = PlantPhylum.all.order(:name)
    gon.icon = ActionController::Base.helpers.asset_path("plant_icon.png")
  end
end
