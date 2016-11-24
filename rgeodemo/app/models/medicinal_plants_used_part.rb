class MedicinalPlantsUsedPart < ActiveRecord::Base

	belongs_to :medicinal_plant, foreign_key: :medicinal_plant_id
	belongs_to :used_part, foreign_key: :used_part_id
end
