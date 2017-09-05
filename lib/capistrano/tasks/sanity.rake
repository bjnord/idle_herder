namespace :sanity do

  desc "Did you intend to deploy without pushing?"
  task :pushed do
    on roles(:app) do
      unless Capistrano.dry_run?
        system("bin/push_check")
      end
    end
  end

end
