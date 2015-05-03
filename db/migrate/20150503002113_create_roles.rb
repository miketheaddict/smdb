class CreateRoles < ActiveRecord::Migration
  def up
    create_table :roles do |t|
      t.belongs_to :film, index: true
      t.belongs_to :filmmaker, index: true
      t.string :credit
      t.timestamps null: false
    end
  end
  def down
  	drop_table :roles
  end
end
