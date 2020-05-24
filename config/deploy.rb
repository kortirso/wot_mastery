# config valid for current version and patch releases of Capistrano
lock '~> 3.14.0'

# Fetch ruby version from .ruby-version
set :rvm_ruby_version, File.read('.ruby-version').strip

set :application, 'wot_mastery'
set :repo_url, 'git@github.com:kortirso/wot_mastery.git'

set :deploy_to, '/var/www/html/wot_mastery'
set :deploy_user, 'deploy'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/master.key')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end

namespace :yarn do
  desc 'Yarn'
  task :install do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, 'exec yarn install'
        end
      end
    end
  end
end

after 'bundler:install', 'yarn:install'
after 'deploy:published', 'bundler:clean'
