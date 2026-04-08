class TravelReviewsController < ApplicationController
  before_action :set_travel_spot, except: [ :index ]
  before_action :set_review, only: [ :edit, :update, :destroy ]
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @reviews = TravelReview.includes(:travel_spot, :user).order(created_at: :desc)
  end

  def new
    @review = @travel_spot.travel_reviews.build
  end

  def create
    @review = @travel_spot.travel_reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to travel_spot_path(@travel_spot), notice: "후기가 등록되었습니다."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to travel_spot_path(@travel_spot), notice: "후기가 수정되었습니다."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to travel_spot_path(@travel_spot), notice: "후기가 삭제되었습니다."
  end

  private

  def set_travel_spot
    @travel_spot = TravelSpot.find(params[:travel_spot_id])
  end

  def set_review
    @review = @travel_spot.travel_reviews.find(params[:id])
  end

  def review_params
    params.require(:travel_review).permit(:title, :content, :rating, :visited_at, :cover_image, photos: [])
  end
end
