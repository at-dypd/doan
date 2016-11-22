class CreatePlantClasses < ActiveRecord::Migration
  def change
    create_table :plant_classes do |t|
    	t.string :name
    	t.text :description
      t.timestamps null: false
    end
  end
end
