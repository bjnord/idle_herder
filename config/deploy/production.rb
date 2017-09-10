set :stage, :production

set :deploy_to, "/home/herder/#{fetch(:application)}"
server "idleherder.com", user: "herder", roles: %w{app db web}

set :repo_url, "git@github.com:bjnord/idle_herder.git"
set :branch, "production"
