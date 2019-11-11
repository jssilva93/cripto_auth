module Api
  module Mobile
    class UsersController < Api::Mobile::ApiMobileApplicationController
      include Api::Mobile::ApiMobileHelper

      def update
        saved = current_customer.update_attributes user_params
        default_response current_customer, saved, error_messages(current_customer)
      end

      def create
        @user = User.new user_params
        @session = @user.sessions.new device_params


        if @user.valid? && @session.valid?

          @user.save!
          @session.save
          render json: @session
        else
          errors = @user.errors.full_messages + @session.errors.full_messages
          render json: errors.join(', '), status: :unprocessable_entity
        end
      end

      def show
        render json: current_customer
      end

      def profile
        render json: current_customer
      end

      private

      def user_params
        params.require(:user).permit!
      end

      def device_params
        params.require(:device).permit!
      end
    end
  end
end