require 'rspec/expectations'


RSpec::Matchers.define :have_class do |expected_|
  match do |actual|
    actual.match(/class\=(?:"|').*(#{expected}).*(?:"|')/)
    $1.present?
  end
  
  description do
      "have CSS class \"#{expected}\""
    end
  
  failure_message do |actual|
    "expected #{actual} to have CSS class \"#{expected}\""
  end
  
  failure_message_when_negated do |actual|
    "expected #{actual} not to have CSS class \"#{expected}\""
  end
  
end

RSpec::Matchers.define :have_id do |expected_|
  match do |actual|
    actual.match(/id\=(?:"|')(#{expected})(?:"|')/)
    $1.present?
  end
  
  description do
      "have CSS id \"#{expected}\""
    end
  
  failure_message do |actual|
    "expected #{actual} to have CSS id \"#{expected}\""
  end
  
  failure_message_when_negated do |actual|
    "expected #{actual} not to have CSS id \"#{expected}\""
  end
  
end