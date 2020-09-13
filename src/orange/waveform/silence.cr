require "./wave"

module Orange
  module Waveform
    class Silence < Wave
      def self.sample(_second : Float64, _frequency : Float64)
        0.0
      end
    end
  end
end
