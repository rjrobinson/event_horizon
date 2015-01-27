module Notifications
  class FlowDock
    FROM_SOURCE = 'Launch Pass'
    EMAIL = 'hello@launchacademy.com'

    def initialize(*args)
      @message_args = args.first
      @flow = Flowdock::Flow.new(
        api_token: token,
        source: FROM_SOURCE,
        from: {
          name: FROM_SOURCE,
          address: EMAIL
        }
      )
    end

    def push_to_team_inbox
      @flow.push_to_team_inbox(
        subject: @message_args[:subject],
        content: @message_args[:message],
        link: @message_args[:link]
      )
    end

    protected
    def token
      if Rails.env.development? || Rails.env.test?
        ENV['FLOWDOCK_TEST_TOKEN']
      else
        ENV['FLOWDOCK_TOKEN']
      end
    end
  end
end
