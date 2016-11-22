class MedicinalPlantsPlantHabitat < ActiveRecord::Base

	belongs_to :medicinal_plant, foreign_key: :medicinal_plant_id
	belongs_to :plant_habitat, foreign_key: :plant_habitat_id
end
