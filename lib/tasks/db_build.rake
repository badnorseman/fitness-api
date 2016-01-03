namespace :db do
  desc 'Build database'
  task :build => ["db:drop", "db:create", "db:migrate"]
end
