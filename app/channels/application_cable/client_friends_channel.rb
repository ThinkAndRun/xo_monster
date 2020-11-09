class ApplicationCable::ClientFriendsChannel < ApplicationCable::Channel
  def subscribed
    logger.info "ClientFriendsChannel => subscribed"
    stream_for current_user
  end
end
