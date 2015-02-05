VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :new_episodes }
  c.filter_sensitive_data("<DEFAULT_CALENDAR_ID>") { ENV["DEFAULT_CALENDAR_ID"] }
end
