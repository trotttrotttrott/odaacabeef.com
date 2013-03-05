class Public::OpscodeController < PublicController

  before_filter :http_auth

  def index
  end

  def run
    render :json => client_side_event(['public:opscode:run', { :status => 'tail...' }])
  end

  def tail
    api = Api::NodeTail.new
    res = api.tail('log/crap')
    render :json => client_side_event(['public:opscode:tail', { :status => 'tailing...', :tail => view_context.simple_format(res['tail']) }])
  end

  private

  def http_auth
    super('test', 'test')
  end
end
