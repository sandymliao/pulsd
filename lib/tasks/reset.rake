namespace :db do
  desc "reset the database, run all scrapers and save to database"
  task :master_reset => :environment do  
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke  
    Rake::Task['db:migrate'].invoke 
    Rake::Task["cron:scrape_sites"].invoke
    Rake::Task["cron:auto_delete"].invoke
    Rake::Task["twilio:send_text"].invoke
  end
end
