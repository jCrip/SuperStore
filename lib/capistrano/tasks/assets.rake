namespace :clean do
  desc 'Runs rake assets:clobber on server to remove compiled assets'
  task :assets do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, 'assets:clobber'
          execute :touch, release_path.join('tmp/restart.txt')
        end
      end
    end
  end
end