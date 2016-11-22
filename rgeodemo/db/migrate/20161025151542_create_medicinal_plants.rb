class CreateMedicinalPlants < ActiveRecord::Migration
  def change
    create_table :medicinal_plants do |t|
    	t.string :name
    	t.string :scientific_name
      t.text :description
    	#foreign_key
    	t.integer :plant_class_id
    	t.integer :plant_phylum_id
    	t.integer :plant_order_id
    	t.integer :plant_kingdom_id
    	t.integer :life_type_id

      t.timestamps null: false
    end
  end
end
