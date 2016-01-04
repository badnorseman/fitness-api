namespace :db do
  desc "build database"
  task :build => ["db:drop", "db:create", "db:migrate"]
end
