require "./wave"

module Orange
  module Waveforms
    class Sine < Wave
      def self.sample(second : Float64, frequency : Float64)
        Math.sin(frequency * second * 2.0 * Math::PI)
      end
    end
  end
end
