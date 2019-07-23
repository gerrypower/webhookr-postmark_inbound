$: << File.join(File.dirname(__FILE__), %w{ .. .. })
require 'test_helper'

describe Webhookr::PostmarkInbound do
  it "must be defined" do
    Webhookr::PostmarkInbound::VERSION.wont_be_nil
  end
end