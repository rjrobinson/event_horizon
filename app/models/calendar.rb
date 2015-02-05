require "google/api_client"

class Calendar < ActiveRecord::Base
  #has_many :calendar_events
  #has_many :events, class_name: CalendarEvent

  validates :name, presence: true
  validates :cid, presence: true

  def events_json
    key = OpenSSL::PKey::RSA.new(ENV["GOOGLE_P12_PEM"], 'notasecret')

    client = Google::APIClient.new(
      application_name: "HorizonDashboard",
      application_version: "0.0.1"
    )

    client.authorization = Signet::OAuth2::Client.new(
      token_credential_uri: "https://accounts.google.com/o/oauth2/token",
      audience: "https://accounts.google.com/o/oauth2/token",
      scope: "https://www.googleapis.com/auth/calendar.readonly",
      issuer: ENV["GOOGLE_SERVICE_ACCOUNT_EMAIL"],
      signing_key: key)

    client.authorization.fetch_access_token!

    response = client.execute(
      api_method: client.discovered_api("calendar", "v3").events.list,
      parameters: {
        calendarId: cid,
        timeMin: DateTime.now.beginning_of_day,
        timeMax: DateTime.now.beginning_of_day + 1.week
      }
    )

    json_data = JSON.parse(response.body)
    json_data["items"]
  end

  def events
    results = []
    events_json.each do |event_json|
      results << CalendarEvent.new(event_json)
    end

    results.sort_by { |e| e.start_time }
  end

  def import_events
    calendar_json["items"].each do |event_json|
      event_params = {
        title: event_json["summary"],
        from: event_json["start"].try(:[], "dateTime") ||
          event_json["start"].try(:[], "date"),
        to: event_json["end"].try(:[], "dateTime") ||
          event_json["end"].try(:[], "date"),
        url: event_json["htmlLink"]
      }

      event = CalendarEvent.find_or_initialize_by(id: event_json["id"])
      event.update_attributes(event_params)
      event.save

      if event.errors.any?
        logger.error "Error Saving event: #{event_json}"
      end
    end
  end
end
