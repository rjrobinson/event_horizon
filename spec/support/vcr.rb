VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :new_episodes }
  c.filter_sensitive_data("<DEFAULT_GOOGLE_CALENDAR_ID>") { ENV["DEFAULT_GOOGLE_CALENDAR_ID"] }
  c.filter_sensitive_data("<GOOGLE_SERVICE_ACCOUNT_EMAIL>") { ENV["GOOGLE_SERVICE_ACCOUNT_EMAIL"] }
  c.filter_sensitive_data("<GOOGLE_P12_PEM>") { ENV["GOOGLE_P12_PEM"] }
end
