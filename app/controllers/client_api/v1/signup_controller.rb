class ClientApi::V1::SignupController < ClientApi::BaseController
  def create
    result = ClientApi::V1::Users::CreateService.perform params
    if result.success?
      user = result.data[:user]
      tokens = ClientApi::V1::Users::GenerateTokensService.perform(user).data[:tokens]
      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)

      render json: { csrf: tokens[:csrf], access: tokens[:access] }
    else
      render_error 422, result.status, result.message
    end
  end
end