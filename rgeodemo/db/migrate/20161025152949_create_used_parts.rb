class CreateUsedParts < ActiveRecord::Migration
  def change
    create_table :used_parts do |t|
    	t.string :name
    	t.text :description
      t.timestamps null: false
    end
  end
end
