require "webhookr"
require "webhookr-postmark_inbound/version"
require "webhookr/ostruct_utils"

module Webhookr
  module PostmarkInbound
    class Adapter
      SERVICE_NAME = "postmark_inbound"
      EVENT_TYPE = "event_type"
      EVENT_KEY = "email"
      PAYLOAD_KEY = "msg"

      include Webhookr::Services::Adapter::Base

      def self.process(raw_response)
        new.process(raw_response)
      end

      def process(raw_response)
        parsed_response = parse(raw_response)
        enhanced_response = {
          PAYLOAD_KEY => parsed_response,
          EVENT_TYPE => EVENT_KEY
        }
        Webhookr::AdapterResponse.new(
          SERVICE_NAME,
          enhanced_response.fetch(EVENT_TYPE),
          OstructUtils.to_ostruct(enhanced_response)
        ) if assert_valid_packet(enhanced_response)
      end

      private

      def parse(raw_response)
        begin
          assert_valid_packets(
            ActiveSupport::JSON.decode(raw_response)
          )
        rescue Exception => e
          raise InvalidPayloadError.new(e)
        end
      end

      def assert_valid_packets(parsed_responses)
        parsed_responses.tap do |p|
          raise(
            Webhookr::InvalidPayloadError, "Malformed response |#{p.inspect}|"
          ) unless p.is_a?(Hash)
        end
      end

      def assert_valid_packet(packet)
        raise(Webhookr::InvalidPayloadError, "Unknown event #{packet[EVENT_TYPE]}") unless packet[EVENT_TYPE]
        raise(Webhookr::InvalidPayloadError, "No msg in the response") unless packet[PAYLOAD_KEY]
        true
      end

    end
  end
end
