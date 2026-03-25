class TravelReview < ApplicationRecord
  belongs_to :travel_spot
  belongs_to :user
  has_one_attached :cover_image
  has_many_attached :photos
  validates :title, presence: true
  validates :content, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
