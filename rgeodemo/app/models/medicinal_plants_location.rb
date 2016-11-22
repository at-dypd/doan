class MedicinalPlantsLocation < ActiveRecord::Base

	belongs_to :medicinal_plant, foreign_key: :medicinal_plant_id
	belongs_to :location, foreign_key: :location_id
end
