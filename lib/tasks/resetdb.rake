namespace :recompile do
  desc "Reset the database"

  task :all => :environment do
    sh "rake db:drop"

    sh "rake db:create"

    sh "rake db:migrate"

    sh "rake db:seed:all"
  end
end
