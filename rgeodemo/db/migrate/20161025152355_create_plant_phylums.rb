class CreatePlantPhylums < ActiveRecord::Migration
  def change
    create_table :plant_phylums do |t|
    	t.string :name
    	t.text :description
      t.timestamps null: false
    end
  end
end
