namespace :fitbird do
  desc 'Build development database'
  task :db_build => ["db:drop", "db:create", "db:migrate", "db:seed"]
end
