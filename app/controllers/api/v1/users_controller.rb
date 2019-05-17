module Api
  module V1
    class UsersController < ApiController
      helper_method :user

      def index
        @users = User.all
        render json: @users
      end

      def show; end

      def update
        user.update!(user_params)
        render :show
      end

      def destroy
        user.destroy!
      end

      private

      def user
        @user ||= User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :username, :gender, :password)
      end
    end
  end
end
