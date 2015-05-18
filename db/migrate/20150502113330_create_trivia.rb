class CreateTrivia < ActiveRecord::Migration
  def up
    create_table :trivia do |t|
    	t.boolean :spoiler
        t.text :body
        t.timestamps null: false
    end
  end

  def down
  	drop_table :trivia
  end
end
