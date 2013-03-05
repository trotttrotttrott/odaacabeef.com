require 'api/json_unwrapper_delegator'
require 'api/node_tail/live'

config = Odaacabeef.config.fetch(:node_tail)

Api::NodeTail.default_source = Api::JsonUnwrapperDelegator.new(
  Api::NodeTail::Live.new(
    config[:host], config[:port]
  )
)

Rails.logger.info "Initialized NodeTail at #{config[:host]}:#{config[:port]}"
