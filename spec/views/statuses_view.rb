module HelpersViewMethods
  def has_status(status, json = nil)
    json.uri.should == status.uri
    json.id.should == status.id.as_json
    json.name.should == status.name
    json.function.id.should == status.function_id.as_json if status.function
    json.function.should == nil if !status.function
    json.created_at.should_not be_nil
    json.updated_at.should_not be_nil

    json.properties.each_with_index do |json_property, i|
      property = StatusPropertyDecorator.decorate(status.properties[i])
      json_property.id.should == property.property_id.as_json
      json_property.uri.should == property.uri
      json_property[:values].should == property.values if property.values
      json_property.ranges.should == property.ranges if property.ranges
      json_property[:pending].should == property.pending
    end
  end
end

RSpec.configuration.include HelpersViewMethods
