class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :title
      t.integer :year
      t.string :synopsis

      t.timestamps null: false
    end
  end

  def down
  	drop_table :films
  end
end
