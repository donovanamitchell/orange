require "./wave"

module Orange
  module Waveform
    class Square < Wave
      def self.sample(second : Float64, frequency : Float64)
        second % (1.0 / frequency) > 0.5 / frequency ? 1.0 : -1.0
      end
    end
  end
end
