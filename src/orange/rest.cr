module Orange
  class Rest < Note
    def initialize(@duration)
      @frequency = 0.0
      @waveform = Waveform::Silence
    end

    def sample(_second : Float)
      0.0
    end
  end
end
