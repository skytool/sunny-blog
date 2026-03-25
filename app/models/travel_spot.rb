class TravelSpot < ApplicationRecord
  has_many :travel_reviews, dependent: :destroy
  has_one_attached :cover_image
  has_many_attached :photos
  validates :name, presence: true
  validates :country, presence: true
end
