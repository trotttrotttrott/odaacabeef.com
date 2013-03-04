class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def http_auth(u, p)
    authenticate_or_request_with_http_basic do |u_entered, p_entered|
      u_entered == u && p_entered == p
    end
  end
end
