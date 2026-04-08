module Admin
  class TravelReviewsController < BaseController
    before_action :set_review, only: [ :destroy ]

    def index
      @reviews = TravelReview.includes(:travel_spot, :user).order(created_at: :desc)
    end

    def destroy
      @review.destroy
      redirect_to admin_travel_reviews_path, notice: "후기가 삭제되었습니다."
    end

    private

    def set_review
      @review = TravelReview.find(params[:id])
    end
  end
end
