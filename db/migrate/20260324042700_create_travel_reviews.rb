class CreateTravelReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :travel_reviews do |t|
      t.string :title
      t.text :content
      t.integer :rating
      t.references :travel_spot, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :cover_image
      t.date :visited_at

      t.timestamps
    end
  end
end
