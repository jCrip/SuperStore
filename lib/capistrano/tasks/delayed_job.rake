namespace :delayed_job do

  desc "Install Deployed Job executable if needed"
  task :install do
    on roles(delayed_job_roles) do |host|
      within release_path do
        # Only install if not already present
        unless test("[ -f #{release_path}/#{delayed_job_bin} ]")
          with rails_env: fetch(:rails_env) do
            execute :bundle, :exec, :rails, :generate, :delayed_job
          end
        end
      end
    end
  end

  before :start, :install
  before :restart, :install

end