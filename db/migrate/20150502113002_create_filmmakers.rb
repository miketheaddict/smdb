class CreateFilmmakers < ActiveRecord::Migration
  def change
    create_table :filmmakers do |t|
      t.string :firstName
      t.string :lastName
      t.date :birthDate
      t.string :bio
      t.string :school
      t.integer :year

      t.string :url

      t.timestamps null: false
    end
  end
end
