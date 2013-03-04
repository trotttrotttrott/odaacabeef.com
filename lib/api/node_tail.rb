class Api::NodeTail

  def initialize(host, port, path_prefix='', agent=Api::HttpAgent)
    base_uri = "http://#{host}:#{port}/#{path_prefix}".chomp('/')
    headers  = { 'Accept' => 'application/json', 'User-Agent' => 'odaacabeef' }
    @http = agent.new(base_uri, headers)
  end

  def run_command(command)
    @http.get "/run_command/#{command}"
  end

  def tail_command(command)
    @http.get "/tail_command/#{command}"
  end
end
