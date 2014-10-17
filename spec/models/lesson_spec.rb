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

  describe ".import!" do
    let(:sample_lessons_dir) { Rails.root.join("spec/data/sample_lessons") }

    it "creates a new lesson" do
      Lesson.import!(File.join(sample_lessons_dir, "expressions"))

      expect(Lesson.count).to eq(1)

      lesson = Lesson.find_by!(slug: "expressions")
      expect(lesson.title).to eq("Expressions")
      expect(lesson.type).to eq("article")
      expect(lesson.description).to eq("bloop.")
      expect(lesson.body).to eq("beep boop i'm an expression\n")
      expect(lesson.position).to eq(1)
    end

    it "updates an existing lesson" do
      FactoryGirl.create(:lesson, slug: "expressions", body: "blah")

      Lesson.import!(File.join(sample_lessons_dir, "expressions"))

      expect(Lesson.count).to eq(1)

      lesson = Lesson.find_by!(slug: "expressions")
      expect(lesson.body).to eq("beep boop i'm an expression\n")
    end

    it "packages an archive for a challenge" do
      Lesson.import!(File.join(sample_lessons_dir, "rock-paper-scissors"))

      expect(Lesson.count).to eq(1)

      lesson = Lesson.find_by!(slug: "rock-paper-scissors")
      expect(lesson.type).to eq("challenge")
      expect(lesson.archive).to_not eq(nil)
    end
  end
end
