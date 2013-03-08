class Public::OpscodeController < PublicController

  before_filter :http_auth
  before_filter :redirect_unless_xhr, :only => [:run, :tail]

  def index
    @chef = view_context.simple_format(CGI::escapeHTML(render_to_string(:partial => 'chef')).gsub(' ', '&nbsp;'), :class => 'chef')
  end

  def about_node_monitor
  end

  def gist
  end

  def run
    api = Api::NodeTail.new
    res = api.run(Odaacabeef.config[:opscode][:run_command])
    render :json => client_side_event(['public:opscode:run', { :status => "###" }])
  end

  def tail
    api = Api::NodeTail.new
    res = api.tail(Odaacabeef.config[:opscode][:tail_path], params[:from])
    render :json => client_side_event(['public:opscode:tail',
                                      { :status => "running chef-client - pid #{res['pid']}",
                                        :tail => view_context.simple_format(CGI::escapeHTML(res['tail'])),
                                        :from => res['from'], :to => res['to'],
                                        :running => res['running'] }])
  end

  private

  def http_auth
    super('opscode', 'nodemonitor')
  end

  def redirect_unless_xhr
    redirect_to :action => :index unless request.xhr?
  end
end
