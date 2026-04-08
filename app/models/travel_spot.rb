class TravelSpot < ApplicationRecord
  has_many :travel_reviews, dependent: :destroy
  validates :name, presence: true
  validates :country, presence: true
end
