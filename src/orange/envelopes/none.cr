module Orange
  module Envelopes
    class None < Envelope
      def initialize
      end

      def amplitude_multiplier(_second, _duration)
        1.0
      end
    end
  end
end