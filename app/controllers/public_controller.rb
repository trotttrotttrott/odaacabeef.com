require 'modules/client_side_event'

class PublicController < ApplicationController

  include ClientSideEvent

  layout 'public'

end
