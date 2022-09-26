require 'sidekiq'

sidekiq_url = ENV['JOB_WORKER_URL'] || "redis://localhost:6379/11"

Sidekiq.configure_client do |config|
  config.redis = {url: sidekiq_url}
end

Sidekiq.configure_server do |config|
  config.redis = {url: sidekiq_url}
end

class Worker
  include Sidekiq::Worker

  def perform(complexity)
    case complexity
    when "super_hard"
      # raise "something bad happened..."
      logger.info "Really took a bit of effort"
    when "hard"
      sleep 2
      logger.info "That was a bit of work"
    else
      logger.info "That wasn't a lot of effort"
    end
  end
end
