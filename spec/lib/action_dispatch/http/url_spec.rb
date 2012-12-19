require "spec_helper"


describe ActionDispatch::Http::URL do

  class FakeURL
    include ActionDispatch::Http::URL
    attr_accessor :protocol
  end

  it "should deduce protocole name from protocol" do
    url = FakeURL.new

    url.protocol = "http://"
    url.protocol_name.should == "http"

    url.protocol = "https://"
    url.protocol_name.should == "https"
  end

end
