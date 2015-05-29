class CreateTrivia < ActiveRecord::Migration
  def change
    create_table :trivia do |t|
    	t.boolean :spoiler
      t.text :body
      t.timestamps null: false
    end

    create_table :films_trivia, :id => false do |t|
      t.integer "film_id"
      t.integer "trivium_id"
    end
    add_index :films_trivia, ["film_id", "trivium_id"]

    create_table :filmmakers_trivia, :id => false do |t|
      t.integer "filmmaker_id"
      t.integer "trivium_id"
    end
    add_index :filmmakers_trivia, ["filmmaker_id", "trivium_id"]
  end
end
