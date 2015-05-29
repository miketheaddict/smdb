class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :title
      t.integer :year
      t.text :synopsis

      t.string :url
      t.string :password

      t.timestamps null: false
    end
  end
end
