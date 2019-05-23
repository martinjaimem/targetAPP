module Api
  module V1
    class UsersController < ApiController
      helper_method :user

      def show;end

      def update
        user.update!(user_params)
        render :show
      end

      private

      def user
        @user ||= User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(
          :first_name, :last_name, :email, :username, :gender, :password, :push_token
        )
      end
    end
  end
end
