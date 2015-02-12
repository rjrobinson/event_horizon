class CalendarEvent
  attr_reader :summary, :url

  def initialize(json_data)
    @json_data = json_data
    @summary = @json_data["summary"]
    @url = @json_data["htmlLink"]
  end

  def start_time
    parse_date_string("start")
  end

  def end_time
    parse_date_string("end")
  end

  protected
  def parse_date_string(key)
    return unless @json_data[key]
    if @json_data[key]["date"]
      return Date.parse(@json_data[key]["date"])
    elsif @json_data[key]["dateTime"]
      return DateTime.parse(@json_data[key]["dateTime"])
    end
    nil
  end
end
