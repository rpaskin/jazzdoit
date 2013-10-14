root = "/home/ubuntu/rails_apps/jazzdoit"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"
 
#listen "/tmp/unicorn.jazzdoit.sock"
worker_processes 2
timeout 30
listen "127.0.0.1:8080"
