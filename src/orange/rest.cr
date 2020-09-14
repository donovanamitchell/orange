module Orange
  class Rest < Note
    def initialize(@duration)
      @frequency = 0.0
      @waveform = Waveforms::Silence
      @envelope = Envelopes::None.new
    end

    def sample(_second : Float)
      0.0
    end
  end
end
