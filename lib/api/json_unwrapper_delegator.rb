class Api::JsonUnwrapperDelegator

  class InvalidResponse < StandardError

    attr :response

    def initialize(response)
      @response = response
      super(response.fetch('message'))
    end
  end

  def initialize(source, logger=Rails.logger)
    @source = source
    @logger = logger
  end

  def method_missing(method, *args, &block)
    if @source.respond_to?(method)
      defined_method = define_singleton_method(method) do |*args, &block|
        unwrap @source.send(method, *args, &block)
      end
      defined_method.call(*args, &block)
    else
      super
    end
  end

  def respond_to?(method, include_private=false)
    @source.respond_to?(method, include_private) || super
  end

  # Parse the JSON response, and expect the resulting object has a "success"
  # key, that returns a true value.
  #
  # If that fails, raises an +InvalidResponse+.
  def unwrap(json)
    JSON.parse(json).tap do |response|
      raise(InvalidResponse, response) unless response.fetch('success')
    end
  rescue => exception
    @logger.error '== Error processing a response from the backend server =='
    @logger.error exception.message
    @logger.error '  ' + exception.backtrace.join("\n  ")
    raise
  end
end
