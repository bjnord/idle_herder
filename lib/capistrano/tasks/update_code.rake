namespace :deploy do

  desc 'Deploy without changing the "current" symlink or restarting.'
  task :update_code do
    set(:deploying, true)
    %w{ starting started updating updated }.each do |task|
      invoke "deploy:#{task}"
    end
  end

end
