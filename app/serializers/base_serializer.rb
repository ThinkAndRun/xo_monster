class BaseSerializer < ActiveModel::Serializer
  def read_attribute_for_serialization(key)
    value = super
    value = custom_serealization value
    value = value.map { |v| custom_serealization(v) } if value.class == Array
    value
  end

  def custom_serealization(value)
    case value
    when Date
      value.strftime '%d-%m-%Y'
    when Time, DateTime
      value.to_i
    else
      value
    end
  end
end
