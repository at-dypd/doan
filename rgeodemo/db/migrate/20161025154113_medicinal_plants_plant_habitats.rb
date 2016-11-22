class MedicinalPlantsPlantHabitats < ActiveRecord::Migration
  def change
  	create_table :medicinal_plants_plant_habitats do |t|
	  	#foreign_key
	    t.column :medicinal_plant_id, :integer
	    t.column :plant_habitat_id, :integer
	    t.timestamps null: false
	  end

	  #add foreign_key
	  add_foreign_key :medicinal_plants_plant_habitats, :medicinal_plants
	  add_foreign_key :medicinal_plants_plant_habitats, :plant_habitats
  end
end
