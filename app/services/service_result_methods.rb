module ServiceResultMethods
  def build_result(success:, status:, message: nil, data: {})
    Hashie::Mash.new(
      success?: success,
      failure?: !success,
      status: status,
      message: message,
      data: data
    )
  end

  def success_result(status: :success, message: nil, data: {})
    build_result success: true, status: status, message: message, data: data
  end

  def error_result(status: :error, message: nil, data: {})
    build_result success: false, status: status, message: message, data: data
  end

  def invalid_params_result(object)
    message = object.is_a?(ActiveRecord::Base) ? "#{object.model_name.human}: #{object.errors.full_messages.join('. ')}" : object
    build_result success: false, status: :invalid_params, message: message
  end
end
