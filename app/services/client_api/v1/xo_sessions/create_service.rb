module ClientApi::V1
  module XoSessions
    class CreateService < ::SaveServices::CreateService
      private

      def permitted_attributes
        params.permit(
          :o_user_id,
          settings: {},
        ).merge!({ x_user_id: current_user.id })
      end

      def build_object
        XoSession.new
      end
    end
  end
end
