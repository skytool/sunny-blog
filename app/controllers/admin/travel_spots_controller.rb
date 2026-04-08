module Admin
  class TravelSpotsController < BaseController
    before_action :set_travel_spot, only: [ :edit, :update, :destroy ]

    def index
      @travel_spots = TravelSpot.includes(:travel_reviews).order(created_at: :desc)
    end

    def new
      @travel_spot = TravelSpot.new
    end

    def create
      @travel_spot = TravelSpot.new(travel_spot_params)
      if @travel_spot.save
        redirect_to admin_travel_spots_path, notice: "여행지가 생성되었습니다."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @travel_spot.update(travel_spot_params)
        redirect_to admin_travel_spots_path, notice: "여행지가 수정되었습니다."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @travel_spot.destroy
      redirect_to admin_travel_spots_path, notice: "여행지가 삭제되었습니다."
    end

    private

    def set_travel_spot
      @travel_spot = TravelSpot.find(params[:id])
    end

    def travel_spot_params
      params.require(:travel_spot).permit(:name, :country, :city, :description, :latitude, :longitude, :cover_image)
    end
  end
end
