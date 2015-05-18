class CreateExtras < ActiveRecord::Migration
  def up
  	create_table :extra_trivium, id: false do |t|
      t.belongs_to :extra, index: true
      t.belongs_to :trivium, index: true
      t.integer :include_id
      t.string :include_type
    end
  	create_table :extra_medium, id: false do |t|
      t.belongs_to :extra, index: true
      t.belongs_to :medium, index: true
      t.integer :include_id
      t.string :include_type
    end
    create_table :extras do |t|
      t.belongs_to :trivium, index: true
      t.integer :include_id
      t.string :include_type
    end
  end
  def down
  	drop_table :extra_trivium
  	drop_table :extra_medium
    drop_table :extras
  end
end
