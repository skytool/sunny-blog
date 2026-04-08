module Admin
  class BaseController < ApplicationController
    layout "admin"
    before_action :authenticate_user!
    before_action :require_admin!

    def dashboard
      @posts_count = Post.count
      @published_count = Post.published.count
      @travel_spots_count = TravelSpot.count
      @reviews_count = TravelReview.count
      @comments_count = Comment.count
      @recent_posts = Post.recent.limit(5)
      @recent_reviews = TravelReview.order(created_at: :desc).limit(5)
    end

    private

    def require_admin!
      redirect_to root_path, alert: "관리자만 접근할 수 있습니다." unless current_user.admin?
    end
  end
end
