class Public::OpscodeController < PublicController

  before_filter :http_auth

  def index
  end

  private

  def http_auth
    super('test', 'test')
  end
end
