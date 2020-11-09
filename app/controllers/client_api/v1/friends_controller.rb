class ClientApi::V1::FriendsController < ClientApi::BaseController
  before_action :authorize_access_request!

  def index
    render json: current_user.friends,
           each_serializer: ClientApi::V1::FriendSerializer,
           root: 'friends'
  end
end