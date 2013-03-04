module ClientSideEvent

  @@queue = []

  # Public: builds a hash that marqeta.js can use for triggering events.
  #
  # *events - any number of arrays containing event data
  #           [0] is always the name of the event/private method (w/o cse_ prefix) that builds the desired event.
  #           [1..] are whatever arguments the method expects.
  #
  # Examples
  #
  #   render :json => client_side_event(['authenticate', i18n_message])
  #   # => { :events => { :name => 'authenticate', :data => { :message => 'whatever i18n_message is' } }
  #
  # Returns a Hash
  def client_side_event(*events)
    events += @@queue
    @@queue = []
    { :events =>
      events.collect do |event|
        { :name => event[0], :data => self.send("cse_#{event.slice!(0)}", *event) }
      end
    }
  end

  # Public: adds an event array to @@queue to later be included in the client_side_event hash
  #         this is so you can add events from multiple classes and methods throughout the life of a request
  #         and have them all end up in the same place.
  #
  # Examples:
  #
  #   enqueue_client_side_event(['google_analytics_registration_success', current_customer])
  #
  def enqueue_client_side_event(*events)
    @@queue += events
  end

  private

  # Private: For creating unique client side events whose arguments are better managed from its caller.
  #
  # Leveraging this method should mean that the event has only 1 caller and at least one of the following statements are true:
  #
  # - the event has no arguments.
  # - the event has very simple arguments.
  # - the event has very few (like 1) subscriber(s) client side.
  def method_missing(meth, *args, &block)
    case args.size
    when 0
    when 1 # no need for an array
      args.first
    else # stays an array
      args
    end
  end
end
