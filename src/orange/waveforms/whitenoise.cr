require "./wave"

module Orange
  module Waveforms
    class Whitenoise < Wave
      def self.sample(_second : Float64, _frequency : Float64)
        Random.rand
      end
    end
  end
end
