module SaveServices
  class UpdateService < Base
    def initialize(object, params, current_user = nil, options = {})
      @object = object
      @params = prepare_params params
      @current_user = current_user
      @options = options
    end
  end
end
