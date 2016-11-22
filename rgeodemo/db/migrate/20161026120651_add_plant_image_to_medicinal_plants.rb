class AddPlantImageToMedicinalPlants < ActiveRecord::Migration
  def change
    add_column :medicinal_plants, :plant_images, :json
  end
end
