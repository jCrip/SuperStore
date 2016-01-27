set :stage, :production
set :rails_env, :production

server '162.243.23.213', port: 22, user: 'deploy', roles: %w{web app}, primary: true
server '162.243.23.213', port: 22, user: 'deployuser', roles: %w{db}