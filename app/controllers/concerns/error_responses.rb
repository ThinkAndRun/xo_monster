module ErrorResponses
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error 404, :record_not_found, 'Record not found'
    end

    rescue_from ActiveRecord::RecordNotUnique do |e|
      render_error 422, :record_not_unique, 'Record not Unique'
    end

    rescue_from JWTSessions::Errors::Unauthorized do |e|
      render_error 401, :unauthorized, 'Not authorized'
    end
  end

  protected

  def render_error(status, error, error_description = nil)
    error_description ||= error
    logger.info "render_error -> #{status}: #{ error }, description: #{ error_description }"
    render json: { error: error, error_description: error_description }, status: status
  end
end
