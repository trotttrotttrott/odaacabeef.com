require 'api/api_proxy'

class Api::NodeTail < Api::ApiProxy
  delegate :run,
           :tail,

           :to => :source
end
