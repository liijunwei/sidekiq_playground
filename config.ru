require 'sidekiq'
require 'webrick'

sidekiq_url = ENV['JOB_WORKER_URL'] || "redis://localhost:6379/11"

Sidekiq.configure_client do |config|
  config.redis = {url: sidekiq_url}
end

require 'sidekiq/web'
use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400
run Sidekiq::Web
