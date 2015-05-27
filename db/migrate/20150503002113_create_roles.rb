class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :film
      t.references :filmmaker
      t.string :credit
      t.boolean :cast
      t.timestamps null: false
    end
    add_index :roles, ["film_id", "filmmaker_id"]
  end
end
