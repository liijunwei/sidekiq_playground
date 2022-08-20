worker_file = "./worker.rb"

desc 'Start worker'
task :worker do
  sh "bundle exec sidekiq -r #{worker_file}"
end

desc 'Start console'
task :console do
  sh "bundle exec pry -r #{worker_file}"
end

desc 'Print usage'
task :help do
  puts "Start worker -> open sepreate commandline prompt -> start console"
  puts "  bundle exec rake -T"
  puts
end

task default: %i[help]
