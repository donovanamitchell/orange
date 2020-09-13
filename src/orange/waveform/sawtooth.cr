require "./wave"

module Orange
  module Waveform
    class Sawtooth < Wave
      def self.sample(second : Float64, frequency : Float64)
        2.0 * frequency * (second % (1.0 / frequency)) - 1.0
      end
    end
  end
end
