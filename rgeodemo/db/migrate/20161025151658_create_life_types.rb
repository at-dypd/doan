class CreateLifeTypes < ActiveRecord::Migration
  def change
    create_table :life_types do |t|
    	t.string :name
    	t.text :description
      t.timestamps null: false
    end
  end
end
