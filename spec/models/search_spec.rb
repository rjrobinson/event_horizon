require "rails_helper"

describe Search do
  describe "#results" do
    let!(:foo) do
      FactoryGirl.create(:assignment,
                         title: "Blah",
                         body: "i like pizza")
    end

    let!(:bar) do
      FactoryGirl.create(:challenge,
                         title: "Shazbot",
                         body: "Ruby sure is fun.")
    end

    let!(:baz) do
      FactoryGirl.create(:assignment,
                         title: "Mr. Grumblecat",
                         body: "Ruby gems and fiddle sticks.")
    end

    it "searches by title" do
      results = Search.results("blah")

      expect(results).to include(foo)
      expect(results).to_not include(bar)
      expect(results).to_not include(baz)
    end

    it "searches by body" do
      results = Search.results("ruby")

      expect(results).to_not include(foo)
      expect(results).to include(bar)
      expect(results).to include(baz)
    end

    it "ignores order of query terms" do
      results = Search.results("stick fiddle")

      expect(results).to_not include(foo)
      expect(results).to_not include(bar)
      expect(results).to include(baz)
    end
  end
end
