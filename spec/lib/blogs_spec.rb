require "spec_helper"

describe Blogit::Blogs do
  it "is included in ActiveRecord::Base" do
    expect(ActiveRecord::Base.included_modules).to include(described_class)
  end

  describe :blogs do
    it "is a class macro to AR Base" do
      expect(ActiveRecord::Base.methods).to include(:blogs)
    end
  end
end
