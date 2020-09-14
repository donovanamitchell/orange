require "./envelope"

module Orange
  module Envelopes
    # Attack, Decay, Sustain, Release
    # https://en.wikipedia.org/wiki/Envelope_(music)
    class Adsr < Envelope
      property attack_amplitude : Float64
      property attack_time : Float64
      property decay_time : Float64
      property release_time : Float64
      property sustain_amplitude : Float64

      def initialize(
          *,
          @attack_amplitude = 1.0,
          @attack_time = 0.0,
          @decay_time = 0.0,
          @release_time = 0.0,
          @sustain_amplitude = 1.0,
        )
      end

      def amplitude_multiplier(second, duration)
        if second <= @attack_time
          # attack
          second * @attack_amplitude / @attack_time
        elsif second - @attack_time <= decay_time
          # decay
          @attack_amplitude - ((second - @attack_time) * (@attack_amplitude - @sustain_amplitude) / @decay_time)
        elsif second <= duration - @release_time
          #sustain
          @sustain_amplitude
        else
          # release
          @sustain_amplitude * (duration - second) / @release_time
        end
      end
    end
  end
end
