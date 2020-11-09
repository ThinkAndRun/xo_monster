class ApplicationCable::XoSessionChangesChannel < ApplicationCable::Channel
  def subscribed
    logger.info "XoSessionChangesChannel => subscribed"
    stream_for xo_session
  end

  def xo_session
    @xo_session ||= XoSession.find_by(slug: params[:slug])
  end
end
