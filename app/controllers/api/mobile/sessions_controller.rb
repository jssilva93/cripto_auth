module Api
  module Mobile
    class SessionsController < Api::Mobile::ApiMobileApplicationController
      include Api::Mobile::ApiMobileHelper

      #skip_before_action :current_user, :current_session, only: [:create]

      def create
        valid, obj = User.sign_in(device_params, session_params, oauth_params)
        default_response obj, valid, obj
      end

      def checkin
        current_session.update_attributes device_params
        obj = {}

        if current_customer.commerce.present?
          obj[:commerce] = {}
          obj[:commerce][:id] = current_customer.commerce.id.to_s
          obj[:commerce][:name] = current_customer.commerce.name
        else
          obj[:commerce] = nil
        end
        default_response obj, true, ""
      end

      private

      def session_params
        params.require(:session).permit!
      end
      def device_params
        params.require(:device).permit!
      end
      def oauth_params
        {}#params.require(:oauth).permit!
      end

    end
  end
end
