class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :type
      t.string :url

      t.timestamps null: false
    end

    create_table :films_media do |t|
      t.integer "film_id"
      t.integer "medium_id"
    end
    add_index :films_media, ["film_id", "medium_id"]

    create_table :filmmakers_media do |t|
      t.integer "filmmaker_id"
      t.integer "medium_id"
    end
    add_index :filmmakers_media, ["filmmaker_id", "medium_id"]

  end
end
