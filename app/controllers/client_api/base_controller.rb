class ClientApi::BaseController < ActionController::API
  include ErrorResponses
  include JWTSessions::RailsAuthorization
  serialization_scope nil

  private

  def current_user
    @current_user ||= payload.present? ? User.find(payload['user_id']) : nil
  end
end
