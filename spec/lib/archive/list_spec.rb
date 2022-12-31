require "spec_helper"
require "blogit/archive"
require "injectables/dummy_archiveable"

describe Blogit::Archive::List do
  describe :to_partial_path do
    let(:list) { described_class.new([]) }

    it "returns the class name as a path to partial" do
      expect(list.to_partial_path).to eql("blogit/archive/list")
    end
  end

  describe :years do
    context "when archiveables is empty" do
      let(:list) { described_class.new([]) }

      it "returns an empty array" do
        expect(list.years).to be_empty
      end
    end

    context "when archiveables contains valid archiveables" do
      let(:list) do
        described_class.new([
                              DummyArchiveable.new(2.years.ago),
                              DummyArchiveable.new(2.years.ago),
                              DummyArchiveable.new(2.weeks.ago)
                            ])
      end

      it "returns an empty array" do
        expect(list.years.size).to be(2)
      end
    end

    context "when archiveables doesn't contain valid archiveables" do
      let(:list) do
        described_class.new([Object.new, Object.new])
      end

      it "raises an exception" do
        expect { list.years }.to raise_error(Blogit::Archive::ArchiveError)
      end
    end
  end
end
