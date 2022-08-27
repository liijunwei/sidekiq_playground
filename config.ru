require 'sidekiq'
require 'webrick'
require 'yaml'

redis_config = YAML.load_file("./redis_conf.yml").compact

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

require 'sidekiq/web'
use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400
run Sidekiq::Web
