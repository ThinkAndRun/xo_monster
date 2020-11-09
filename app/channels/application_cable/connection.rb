module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include JWTSessions::RailsAuthorization
    identified_by :current_user
    identified_by :public_user

    def connect
      authorize_access_request!
      puts "ActionCable => connect payload: #{ payload }"

      if current_user
        self.current_user = current_user
        self.public_user = public_user
        logger.info "ActionCable => connected user: #{current_user.name} (#{current_user.email})"
      else
        reject_unauthorized_connection
      end
    rescue
      self.public_user = public_user
      logger.info "ActionCable => connected as Guest"
    end

    private

    def request_headers
      { 'Authorization' => request.query_parameters['token'] }
    end

    def current_user
      @current_user ||= payload.present? ? User.find(payload['user_id']) : nil
    end

    def public_user
      @public_user ||= SecureRandom.uuid
    end
  end
end
