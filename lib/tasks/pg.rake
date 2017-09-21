namespace :pg do
  desc "PostgreSQL full backup to AWS S3 bucket"
  task :backup do
    datestamp = Time.now.utc.strftime("%Y%m%d-%H%MZ")
    backup_file = Rails.root.join('tmp', "pgbackup-#{datestamp}.dump")
    sh "pg_dump -F c herder >#{backup_file}"
    sh "aws s3 cp #{backup_file} s3://idleherder-pgbackups"
    File.delete backup_file
  end
end
