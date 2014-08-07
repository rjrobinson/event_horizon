require "rails_helper"

describe Comment do
  let(:source_file) { FactoryGirl.create(:source_file) }

  describe "validations" do
    it "requires line number if source file set" do
      comment = FactoryGirl.build(:comment)

      comment.source_file = source_file
      comment.line_number = nil
      expect(comment.valid?).to eq(false)

      comment.line_number = 42
      expect(comment.valid?).to eq(true)

      comment.source_file = nil
      expect(comment.valid?).to eq(false)
    end

    it "allows nil line number if no source file" do
      comment = FactoryGirl.build(:comment)
      comment.source_file = nil
      comment.line_number = nil

      expect(comment.valid?).to eq(true)
    end
  end
end
