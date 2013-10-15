require "rvm/capistrano"
require "bundler/capistrano"

set :application, "Jazzdoit"
set :scm, :git
set :repository,  "git@github.com:rpaskin/jazzdoit.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :deploy_to, "/home/ubuntu/rails_apps/cap/#{application}"

set :user, 'ubuntu'
set :scm_username, 'rpaskin'
ssh_options[:keys] = [File.join(ENV["HOME"], "ronnie-keypair.pem")]

server 'ec2-54-221-61-60.compute-1.amazonaws.com', :app, :web, :db, :primary => true

after 'deploy:update_code', 'deploy:migrate'

set :unicorn_binary, "unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end

