namespace :setup do

  desc "Upload database.yml file."
  task :database do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
    end
  end

  desc "Upload secrests.yml file."
  task :secrets do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
    end
  end

  desc "Upload .env file."
  task :env do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read(".env")), "#{shared_path}/.env"
    end
  end

  desc "Seed the database."
  task :seed do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:seed"
        end
      end
    end
  end

end