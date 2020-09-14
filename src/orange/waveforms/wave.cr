module Orange
  module Waveforms
    abstract class Wave
      def self.sample(second, frequency : Float64)
        0.0
      end
    end
  end
end
