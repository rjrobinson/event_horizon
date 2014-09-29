require "rails_helper"

describe Lesson do
  describe ".search" do
    let!(:foo) do
      FactoryGirl
        .create(:lesson, title: "Blah", body: "i like pizza", description: "bloop")
    end

    let!(:bar) do
      FactoryGirl
        .create(:lesson, title: "Shazbot", body: "Ruby sure is fun.")
    end

    let!(:baz) do
      FactoryGirl
        .create(:lesson, title: "Mr. Grumblecat", body: "Ruby gems and fiddle sticks.")
    end

    it "searches by title" do
      results = Lesson.search("blah")

      expect(results).to include(foo)
      expect(results).to_not include(bar)
      expect(results).to_not include(baz)
    end

    it "searches by body" do
      results = Lesson.search("ruby")

      expect(results).to_not include(foo)
      expect(results).to include(bar)
      expect(results).to include(baz)
    end

    it "searches by description" do
      results = Lesson.search("bloop")

      expect(results).to include(foo)
      expect(results).to_not include(bar)
      expect(results).to_not include(baz)
    end

    it "ignores order of query terms" do
      results = Lesson.search("stick fiddle")

      expect(results).to_not include(foo)
      expect(results).to_not include(bar)
      expect(results).to include(baz)
    end
  end
end
