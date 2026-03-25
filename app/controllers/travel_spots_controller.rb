class TravelSpotsController < ApplicationController
  def index
    @travel_spots = TravelSpot.includes(:travel_reviews).all
    @travel_spots = @travel_spots.where("name LIKE ? OR country LIKE ? OR city LIKE ?",
      "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%") if params[:q].present?
  end

  def show
    @travel_spot = TravelSpot.find(params[:id])
    @reviews = @travel_spot.travel_reviews.includes(:user).order(created_at: :desc)
    @new_review = TravelReview.new
  end
end
