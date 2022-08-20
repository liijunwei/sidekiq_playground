worker_file = "./worker.rb"

desc 'Start worker, we can always start multiple workers'
task :worker do
  sh "bundle exec sidekiq -r #{worker_file}"
end

desc 'Start console'
task :console do
  sh "bundle exec pry -r #{worker_file}"
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

desc 'Print sidekiq stats'
task :sidekiqmon do
  sh "sidekiqmon"
end

desc 'Print usage'
task :help do
  puts "Start worker -> open sepreate commandline prompt -> start console"
  puts
  sh "bundle exec rake -T"
  puts
end

desc 'Reset sidekiq stat'
task :reset_sidekiq_stat do
  require 'sidekiq/api'
  require 'json'

  Sidekiq.configure_client do |config|
    config.redis = {db: 1}
  end

  jj Sidekiq::Stats.new.fetch_stats!

  Sidekiq.redis {|c| c.del('stat:processed') }
  Sidekiq.redis {|c| c.del('stat:failed') }

  jj Sidekiq::Stats.new.fetch_stats!
end

task default: %i[help]
