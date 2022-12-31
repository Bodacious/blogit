require "rails_helper"

describe Blogit do
  after :all do
    described_class.configure(&:inspect)
  end

  it "allows developers to set configurations with a block" do
    initial_value = described_class.configuration.current_blogger_method
    described_class.configure do |config|
      config.current_blogger_method = :logged_in_user
    end
    user_set_value = described_class.configuration.current_blogger_method
    expect(initial_value).not_to eql(user_set_value)
  end
end
