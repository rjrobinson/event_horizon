require "rails_helper"

describe SourceFile do
  describe "validations" do
    it "allows files with an empty body but not nil" do
      file = FactoryGirl.build(:source_file)
      file.body = ""
      expect(file.valid?).to eq(true)

      file.body = nil
      expect(file.valid?).to eq(false)
    end
  end
end
