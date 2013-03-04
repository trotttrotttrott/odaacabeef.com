require "net/http"
require "uri"

class Api::HttpAgent

  attr :base_uri

  attr :headers

  def initialize(base_uri, headers={}, params={})
    @base_uri = base_uri.to_s
    @headers = headers
  end

  def get(path, options = {}, &block)
    response = request(:get, path, &block)
    options.fetch(:full_response, false) ? response : response.body
  end

  def post(path, data = {}, options = {}, &block)
    response = request :post, path do |request|
      request.set_form_data(data)
      block.call(request) if block
    end
    options.fetch(:full_response, false) ? response : response.body
  end

  def put(path, data = {}, options = {}, &block)
    response = request :put, path do |request|
      request.set_form_data(data)
      block.call(request) if block
    end
    options.fetch(:full_response, false) ? response : response.body
  end

  def delete(path, options = {}, &block)
    response = request(:delete, path, &block)
    options.fetch(:full_response, false) ? response : response.body
  end

  private

  def request(verb, path)
    path = path.gsub /^\//, ""
    uri  = URI.parse(File.join(base_uri, path))
    request_type = Net::HTTP.const_get(verb.to_s.classify)
    request = request_type.new(uri.request_uri, headers)
    yield request if block_given?
    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout = 600
    http.request(request)
  end
end
