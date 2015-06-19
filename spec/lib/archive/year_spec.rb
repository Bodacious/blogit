require 'spec_helper'
require 'blogit/archive'
require 'injectables/dummy_archiveable'

describe Blogit::Archive::Year do
  
  describe :to_partial_path do
    
    let(:list) { Blogit::Archive::Year.new(2015, []) }
    
    it "returns the class name as a path to partial" do
      expect(list.to_partial_path).to eql("blogit/archive/year")
    end
    
  end
  
  describe :months do

    
    context "when archiveables contains valid archiveables" do
      
      let(:list) { 
        Blogit::Archive::Year.new("2015", [
          DummyArchiveable.new(2.months.ago),
          DummyArchiveable.new(2.months.ago),
          DummyArchiveable.new(2.weeks.ago)
        ])
      }
      
      it "returns an empty array" do
        expect(list.months.size).to eql(2)
      end
      
    end
    
  end
  
end