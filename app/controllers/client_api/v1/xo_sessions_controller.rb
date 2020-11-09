class ClientApi::V1::XoSessionsController < ClientApi::BaseController
  before_action :authorize_access_request!, except: [:show]

  def index
    render_xo_sessions current_user.xo_sessions
  end

  def create
    result = ClientApi::V1::XoSessions::CreateService.perform params, current_user
    if result.success?
      render_xo_session result.data[:xo_session], status: 201
    else
      render_error 422, result.status, result.message
    end
  end

  def show
    render_xo_session resource_xo_session
  end

  private

  def render_xo_session(xo_session, options = {})
    options = options.reverse_merge(
        json: xo_session,
        serializer: ClientApi::V1::XoSessionSerializer
    )
    render options
  end

  def render_xo_sessions(xo_sessions, options = {})
    preloaded_associations = [:winner, :loser, :x_user, :o_user]
    ActiveRecord::Associations::Preloader.new.preload xo_sessions, preloaded_associations
    options = options.reverse_merge(
        json: xo_sessions,
        each_serializer: ClientApi::V1::XoSessionSerializer
    )
    render options
  end

  def resource_xo_session
    @resource_xo_session ||= XoSession.find_by(slug: params[:id])
  end
end
