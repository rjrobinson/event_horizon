namespace :event_horizon do
  task :import_challenges => :environment do
    Challenge.import_all!
  end
end
