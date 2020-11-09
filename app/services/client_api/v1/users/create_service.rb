module ClientApi::V1
  module Users
    class CreateService < ::SaveServices::CreateService
      private

      def permitted_attributes
        params.permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )
      end

      def build_object
        User.new
      end
    end
  end
end
