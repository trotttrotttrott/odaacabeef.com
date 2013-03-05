require 'api/http_agent'
require 'net/http'

class Api::NodeTail::Live

  def initialize(host, port, path_prefix='', agent=Api::HttpAgent)
    base_uri = "http://#{host}:#{port}/#{path_prefix}".chomp('/')
    headers  = { 'Accept' => 'application/json', 'User-Agent' => 'odaacabeef' }
    @http = agent.new(base_uri, headers)
  end

  def run(command)
    @http.get "/run?command=#{command}"
  end

  def tail(file)
    @http.get "/tail?file=#{file}"
  end
end
