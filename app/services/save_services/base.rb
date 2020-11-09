module SaveServices
  class Base
    include ServiceResultMethods

    attr_reader :object, :params, :current_user, :options

    def self.perform(*args)
      new(*args).perform
    end

    def perform
      save_object
    end

    protected

    def save_object
      object.assign_attributes permitted_attributes
      if object.save
        success_result data: { object_name => object }
      else
        invalid_params_result object
      end
    end

    def object_name
      object.model_name.to_s.underscore.to_sym
    end

    def object_params
      params[object_name]
    end

    def permitted_params
      raise '`permitted_params` must be implemented in child class'
    end

    def prepare_params(raw_params)
      result = raw_params.deep_dup
      result = ActionController::Parameters.new(result) unless result.is_a?(ActionController::Parameters)
      result[object_name] ||= ActionController::Parameters.new
      result
    end

    def method_missing(method, *args)
      object_name == method ? object : super
    end
  end
end
