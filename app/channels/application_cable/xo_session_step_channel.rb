require "#{Rails.root}/app/services/client_api/v1/xo_sessions/make_step_service"

class ApplicationCable::XoSessionStepChannel < ApplicationCable::Channel
  def subscribed
    logger.info "XoSessionStepChannel => subscribed"
    stream_from xo_session
  end

  def make_step(data)
    puts "Make step with data: #{data.inspect}, user: #{current_user&.email}"
    ::ClientApi::V1::XoSessions::MakeStepService.perform xo_session, data, current_user
  end

  def xo_session
    @xo_session ||= XoSession.find_by(slug: params[:slug])
  end
end
