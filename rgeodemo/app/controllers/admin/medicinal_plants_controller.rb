class Admin::MedicinalPlantsController < AdminController
	before_action :get_search_condition, only: [:index]
  before_action :set_update_item, only: [:show, :update, :destroy]
  before_action :init_data, only: [:index]

  def index
    @items = @q.result.includes(:plant_habitats).page(params[:page]).per(params[:limit])
                      .order(:name)
  end

  def create
    @item = MedicinalPlant.create(permit_params)
    if @item.errors.blank?
      flash[:success] = "Created"
      used_parts = UsedPart.where(id: params[:used_part_ids].try(:split, ','))
      @item.used_parts << used_parts
      plant_habitats = PlantHabitat.where(id: params[:plant_habitat_ids].try(:split, ','))
      @item.plant_habitats << plant_habitats
    else
      flash[:danger] = "Error"
    end
    redirect_to :back
  end

  def destroy
    @item.destroy
    @item.errors.blank? ? flash[:success] = "Updated" : flash[:danger] = "Error"
    redirect_to :back
  end

  def update
    @item.update(permit_params) ? flash[:success] = "Updated" : flash[:danger] = "Error"
    create_used_parts
    create_plant_habitats
    redirect_to :back
  end

  private

  def create_used_parts
    used_parts = @item.used_parts.pluck(:id)
    if used_parts.blank?
      used_parts = UsedPart.where(id: params[:used_part_ids].try(:split, ','))
      @item.used_parts << used_parts
    elsif used_parts.sort != params[:used_part_ids].try(:split, ',').map{|m| m.to_i}.sort
      @item.used_parts.delete_all
      used_parts = UsedPart.where(id: params[:used_part_ids].try(:split, ','))
      @item.used_parts << used_parts
    end
  end

  def create_plant_habitats
  	plant_habitats = @item.plant_habitats.pluck(:id)
    if plant_habitats.blank?
      plant_habitats = PlantHabitat.where(id: params[:plant_habitat_ids].try(:split, ','))
      @item.plant_habitats << plant_habitats
    elsif plant_habitats.sort != params[:plant_habitat_ids].try(:split, ',').map{|m| m.to_i}.sort
      @item.plant_habitats.delete_all
      plant_habitats = PlantHabitat.where(id: params[:plant_habitat_ids].try(:split, ','))
      @item.plant_habitats << plant_habitats
    end
  end

  def get_search_condition
    @q = MedicinalPlant.ransack(params[:q])
  end

  def set_update_item
    @item = MedicinalPlant.find(params[:id])
  end

  def permit_params
    params.require(:medicinal_plant).permit(MedicinalPlant::DEFAULT_ATTRIBUTES)
  end

  def init_data
    @used_parts = UsedPart.all.order(:name)
    @plant_habitats = PlantHabitat.all.order(:name)
    @plant_orders = PlantOrder.all.order(:name)
    @plant_classes = PlantClass.all.order(:name)
    @plant_kingdoms = PlantKingdom.all.order(:name)
    @plant_phylums = PlantPhylum.all.order(:name)
    @item_new   = MedicinalPlant.new
  end
end
