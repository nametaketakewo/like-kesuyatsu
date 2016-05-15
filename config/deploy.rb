# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'goodbye-stars'
set :repo_url, 'git@gitlab.nametaketakewo.net:nametaketakewo/goodbye-stars.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/usr/share/nginx/goodbye-stars'

# Default value for :scm is :git
set :scm, :git
set :rbenv_type, :system
set :rbenv_ruby, '2.2.2'
# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, (fetch(:linked_dirs) + ['tmp/pids'])

# Default value for default_env is {}
#set :default_env, { path: "/usr/local/rbenv/bin/:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5
set :unicorn_rack_env, 'none'
set :unicorn_config_path, 'config/unicorn.rb'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
  task :resque do
    run "cd #{deploy_to}; RAILS_ENV=production nohup /usr/bin/env rake resque:scheduler &"
    run "cd #{deploy_to}; RAILS_ENV=production nohup /usr/bin/env rake resque:workers &"
  end
end

after 'deploy:publishing', 'deploy:restart'
#after 'deploy:publishing', 'deploy:resque'
