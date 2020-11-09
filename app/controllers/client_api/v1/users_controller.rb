class ClientApi::V1::UsersController < ClientApi::BaseController
  before_action :authorize_access_request!

  def me
    render json: current_user,
           serializer: ClientApi::V1::MeSerializer,
           adapter: :attributes
  end
end
