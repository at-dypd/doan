class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.timestamps null: false
      t.integer :role_id
    end

    add_foreign_key :users, :roles
  end
end
