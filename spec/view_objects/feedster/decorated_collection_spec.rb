require 'rails_helper'

describe Feedster::DecoratedCollection do
  it 'decorates a comment feed item' do
    feed_item = FactoryGirl.create(:comment).feed_items.first
    collection = Feedster::DecoratedCollection.new([feed_item])

    expected_class = Feedster::CommentCreatedDecorator
    expect(collection.decorate.first).
      to be_kind_of(expected_class)
  end

  it 'raises an exception when there is no decorator mapping for the class' do
    feed_item = FeedItem.new do |feed_item|
      feed_item.subject = Team.new
      feed_item.verb = 'create'
    end
    collection = Feedster::DecoratedCollection.new([feed_item])

    expect(lambda{ collection.decorate }).
      to raise_error(Feedster::DecoratorMappingNotFound)
  end

  it 'raises an exception when there is no decorator map for the verb' do
    feed_item = FeedItem.new do |feed_item|
      feed_item.subject = Comment.new
      feed_item.verb = 'wizardize'
    end
    collection = Feedster::DecoratedCollection.new([feed_item])

    expect(lambda{ collection.decorate }).
      to raise_error(Feedster::DecoratorMappingNotFound)
  end
end
