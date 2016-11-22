class MedicinalPlantsUsedParts < ActiveRecord::Migration
  def change
  	create_table :medicinal_plants_used_parts do |t|
	  	#foreign_key
	    t.column :medicinal_plant_id, :integer
	    t.column :used_part_id, :integer
	    t.timestamps null: false
	  end

	  #add foreign_key
	  add_foreign_key :medicinal_plants_used_parts, :medicinal_plants
	  add_foreign_key :medicinal_plants_used_parts, :used_parts
  end
end
