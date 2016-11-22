class CreatePlantOrders < ActiveRecord::Migration
  def change
    create_table :plant_orders do |t|
    	t.string :name
    	t.text :description
      t.timestamps null: false
    end
  end
end
