require "spec_helper"
require "blogit/archive"
require "injectables/dummy_archiveable"

describe Blogit::Archive::Month do
  describe "#to_partial_path" do
    let(:list) { described_class.new("June", []) }

    it "returns the class name as a path to partial" do
      expect(list.to_partial_path).to eql("blogit/archive/month")
    end
  end
end
