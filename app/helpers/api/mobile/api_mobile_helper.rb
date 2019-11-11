module Api
  module Mobile
    module ApiMobileHelper

      def default_response object, succeed, message
        if succeed
          render json: object
        else
          render json: {mssg: message}, status: :unprocessable_entity
        end
      end

      def error_messages object
        object.errors.full_messages.join(", ")
      end

    end
  end
end
