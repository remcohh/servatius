set :application, 'servatius'
set :repo_url, 'git@github.com:remcohh/servatius.git'

set :deploy_to, '/home/deploy/servatius'

set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{storage log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/audios public/scans public/images}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end