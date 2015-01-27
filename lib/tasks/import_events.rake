namespace :horizon do
  desc "Import calendar events"
  task import_events: :environment do
    Calendar.all.each do |calendar|
      calendar.import_events
    end
  end
end
