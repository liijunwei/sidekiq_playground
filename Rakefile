worker_file = "./worker.rb"

desc 'Start worker, we can always start multiple workers'
task :worker do
  sh "bundle exec sidekiq --require #{worker_file} --concurrency 3"
end

desc 'Start console'
task :console do
  sh "bundle exec pry -r #{worker_file} -r sidekiq/api"
end

desc 'Rotate session key'
task :rotate_session_key do
  require 'securerandom'
  File.open(".session.key", "w") {|f| f.write(SecureRandom.hex(32)) }
end

desc 'Start rack server'
task :server => :rotate_session_key do
  sh "bundle exec rackup"
end

desc 'Visit sidekiq web ui'
task :webui do
  sh "open http://localhost:9292"
end

desc 'Print usage'
task :help do
  puts "Start worker -> open sepreate commandline prompt -> start console"
  puts
  sh "bundle exec rake -T"
  puts
end

desc 'Reset redis'
task :reset_redis do
  require 'sidekiq/api'
  require 'json'
  require 'yaml'

  redis_config = YAML.load_file("./redis_conf.yml").compact

  Sidekiq.configure_client do |config|
    config.redis = redis_config
  end

  jj Sidekiq::Stats.new.fetch_stats!

  Sidekiq.redis {|c| c.flushdb }

  puts
  puts "#{redis_config.to_json} flushed"
end

task default: %i[help]
