module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!

    def dashboard
      @posts_count = Post.count
      @published_count = Post.published.count
      @travel_spots_count = TravelSpot.count
      @reviews_count = TravelReview.count
      @comments_count = Comment.count
      @recent_posts = Post.recent.limit(5)
      @recent_reviews = TravelReview.order(created_at: :desc).limit(5)
    end
  end
end
