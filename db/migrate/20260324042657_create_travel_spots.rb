class CreateTravelSpots < ActiveRecord::Migration[8.1]
  def change
    create_table :travel_spots do |t|
      t.string :name
      t.string :country
      t.string :city
      t.text :description
      t.string :cover_image
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
