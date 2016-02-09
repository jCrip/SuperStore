require 'capistrano/setup'

require 'capistrano/deploy'

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/puma'
require 'capistrano/puma/workers'
require 'capistrano/puma/nginx'
require 'capistrano/ssh_doctor'
require 'capistrano/delayed-job'
require 'whenever/capistrano'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
