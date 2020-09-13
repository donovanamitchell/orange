require "./waveform/*"

module Orange
  class Note
    property duration : Float64
    property frequency : Float64
    property waveform : Waveform::Wave.class

    # def initialize(*, frequency, waveform, envelope)

    # end

    def initialize(@duration, @frequency, @waveform = Waveform::Sine)
    end

    def initialize(@duration, note : String, @waveform = Waveform::Sine)
      raise "No note" unless NOTE_FREQUENCIES.has_key?(note)

      @frequency = NOTE_FREQUENCIES[note]
    end

    def sample(second : Float)
      return 0.0 if second > @duration

      @waveform.sample(second, @frequency)
    end
  end
end
