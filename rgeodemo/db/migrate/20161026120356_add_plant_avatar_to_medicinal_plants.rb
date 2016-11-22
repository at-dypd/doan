class AddPlantAvatarToMedicinalPlants < ActiveRecord::Migration
  def change
    add_column :medicinal_plants, :plant_avatar, :string
  end
end
