module ClientApi::V1
  module Users
    class GenerateTokensService
      include ServiceResultMethods

      attr_reader :user

      def self.perform(user)
        new(user).perform
      end

      def initialize(user)
        @user = user
      end

      def perform
        payload  = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        tokens = session.login

        if tokens
          success_result data: {
              tokens: tokens
          }
        else
          error_result status: :invalid_tokens
        end
      end

      private

    end
  end
end
