module Admin
  class UsersController < BaseController
    before_action :set_user, only: [ :destroy ]

    def index
      @users = User.order(created_at: :desc)
    end

    def destroy
      if @user == current_user
        redirect_to admin_users_path, alert: "자기 자신은 삭제할 수 없습니다."
      else
        @user.destroy
        redirect_to admin_users_path, notice: "사용자가 삭제되었습니다."
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
