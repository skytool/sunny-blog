class HomeController < ApplicationController
  def index
    @recent_posts = Post.published.recent.includes(:category, :user).limit(6)
    @featured_spots = TravelSpot.includes(:travel_reviews).limit(4)
    @recent_reviews = TravelReview.includes(:travel_spot, :user).order(created_at: :desc).limit(3)
  end
end
