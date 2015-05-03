class JoinItemsWithMediaAndTrivia < ActiveRecord::Migration
  def up
  	create_table :item_trivium, id: false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :trivium, index: true
    end
  	create_table :item_medium, id: false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :medium, index: true
    end
  end
  def down
  	drop_table :item_trivium
  	drop_table :item_medium
  end
end
