module Orange
  module Envelopes
    abstract class Envelope
      abstract def amplitude_multiplier(second, duration)
    end
  end
end