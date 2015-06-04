namespace :db do
  desc 'Build development database'
  task :build => ["db:drop", "db:create", "db:migrate"]
end
