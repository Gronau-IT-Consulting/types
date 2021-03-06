class StatusSerializer < ApplicationSerializer
  cached true

  attributes :id, :uri, :name, :function, :properties, :created_at, :updated_at

  def uri
    StatusDecorator.decorate(object).uri
  end

  def function
    object.function_id ? { id: object.function_id, uri: object.decorate.function_uri } : nil
  end

  def properties
    object.properties.map do |property|
      property = StatusPropertyDecorator.decorate(property)
      result = { id: property.property_id, uri: property.uri, pending: property.pending }
      result[:values] = property.values || []
      result[:ranges] = property.ranges || []
      result
    end
  end
end
