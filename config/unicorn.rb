root = "/home/ubuntu/rails_apps/cap/Jazzdoit/current"

working_directory root
pid "../../shared/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

#listen "/tmp/unicorn.jazzdoit.sock"
worker_processes 2
timeout 30
listen "127.0.0.1:8080"

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end
