class TestObject < Hyper::Core::Service::Base
  self.resource_scope = 'grable'
  PROPERTIES = %i(id yes no maybe grable_id)
  attr_accessor *PROPERTIES
end
