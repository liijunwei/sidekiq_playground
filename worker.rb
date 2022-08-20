require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = {db: 1}
end

Sidekiq.configure_server do |config|
  config.redis = {db: 1}
end

class OurWorker
  include Sidekiq::Worker

  def perform(complexity)
    case complexity
    when "super_hard"
      raise "something bad happened..."
      puts "Really took a bit of effort"
    when "hard"
      sleep 2
      puts "That was a bit of work"
    else
      puts "That wasn't a lot of effort"
    end
  end
end

