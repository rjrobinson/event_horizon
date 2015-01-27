require 'rails_helper'

describe Notifications::FlowDock do
  describe '#initialize' do
    it 'creates a FlowDock::Flow' do
      Flowdock::Flow.expects(:new).with(
        api_token: ENV['FLOWDOCK_TEST_TOKEN'],
        source: described_class::FROM_SOURCE,
        from: {
          name: described_class::FROM_SOURCE,
          address: described_class::EMAIL
        }
      )
      Notifications::FlowDock.new
    end
  end

  describe '#push_to_inbox' do
    it 'call the push_to_team_inbox on the FlowDock::Flow' do
      flow = mock
      Flowdock::Flow.stubs(:new).returns(flow)

      flow_dock = Notifications::FlowDock.new(
        message: 'hi there',
        subject: 'dan',
        link: 'some/url'
      )

      flow.expects(:push_to_team_inbox).with(
        subject: 'dan',
        content: 'hi there',
        link: 'some/url'
      )

      flow_dock.push_to_team_inbox
    end
  end
end
