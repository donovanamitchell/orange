require "./wave"

module Orange
  module Waveforms
    class Triangle < Wave
      def self.sample(second : Float64, frequency : Float64)
        1 - ((4 * frequency * (second % (1.0 / frequency)) - 2)).abs
      end
    end
  end
end
