module Orange
  class Note
    property duration : Float64
    property envelope : Envelopes::Envelope
    property frequency : Float64
    property waveform : Waveforms::Wave.class

    def initialize(
        *,
        note : String = "None",
        frequency : Float64 | Nil = nil,
        waveform = Waveforms::Sine,
        duration = 0.0,
        envelope = Envelopes::None.new,
      )

      frequency ||= begin
        raise "No note" unless NOTE_FREQUENCIES.has_key?(note)

        NOTE_FREQUENCIES[note]
      end

      @frequency = frequency
      @waveform = waveform
      @envelope = envelope
      @duration = duration
    end

    def sample(second : Float)
      return 0.0 if second > @duration

      @waveform.sample(second, @frequency) * envelope.amplitude_multiplier(second, @duration)
    end
  end
end
