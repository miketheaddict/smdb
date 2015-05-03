class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :type
      t.string :url

      t.timestamps null: false
    end
  end

  def down
  	drop_table :media
  end
end
