require 'sidekiq'
require 'webrick'

Sidekiq.configure_client do |config|
  config.redis = {db: 1}
end

require 'sidekiq/web'
use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400
run Sidekiq::Web
