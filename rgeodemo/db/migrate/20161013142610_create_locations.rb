class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.st_point :latlon, geographic: true

      t.timestamps null: false
    end
  end
end
