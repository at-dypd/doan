class MedicinalPlantsLocations < ActiveRecord::Migration
  def change
  	create_table :medicinal_plants_locations do |t|
	  	#foreign_key
	    t.column :medicinal_plant_id, :integer
	    t.column :location_id, :integer
	    t.column :quantity, :integer
	    t.column :description, :string
	    t.timestamps null: false
	  end

	  #add foreign_key
	  add_foreign_key :medicinal_plants_locations, :medicinal_plants
	  add_foreign_key :medicinal_plants_locations, :locations
  end
end
