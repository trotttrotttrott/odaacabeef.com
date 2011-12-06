Resque.after_fork do |job|
  ActiveRecord::Base.connection.reconnect!
end

Resque.schedule = YAML.load_file(Rails.root.join('config/resque_scheduler.yml'))
