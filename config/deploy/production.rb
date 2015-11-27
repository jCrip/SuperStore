set :stage, :production
set :rails_env, :production

server '52.34.202.228', user: 'ubuntu', roles: %w{web app db}, primary: true