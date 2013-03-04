class Public::OpscodeController < PublicController

  before_filter :http_auth

  def index
  end

  def run_command
    render :json => client_side_event(['public:opscode:run_command', SecureRandom.hex(16)])
  end

  def tail_command
    render :json => client_side_event(['public:opscode:tail_command', SecureRandom.hex(16)])
  end

  private

  def http_auth
    super('test', 'test')
  end
end
