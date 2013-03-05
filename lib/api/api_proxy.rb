class Api::ApiProxy

  class << self
    # Default data source used to delegate methods from this API.
    attr_accessor :default_source
  end

  # Data source to which the implementation is deferred
  attr :source

  # Pass a data source to which delegate the implementation, or delegate to
  # +self.class.default_source+ if none is passed.
  def initialize(source=self.class.default_source)
    @source = source
  end
end
