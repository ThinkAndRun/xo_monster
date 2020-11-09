class ClientApi::V1::SigninController < ClientApi::BaseController
  before_action :authorize_access_request!, only: [:destroy]

  def create
    user = User.find_by!(email: params[:email])
    if user&.authenticate(params[:password])
      tokens = ClientApi::V1::Users::GenerateTokensService.perform(user).data[:tokens]
      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)

      render json: { csrf: tokens[:csrf], access: tokens[:access] }
    else
      render_error 401, :unauthorized, 'Not authorized'
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end
end