class TravelReview < ApplicationRecord
  belongs_to :travel_spot
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
