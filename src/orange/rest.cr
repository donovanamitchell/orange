module Orange
  class Rest < Note
    def initialize(@duration, @waveform = Waveform::Sine)
      @frequency = 0.0
    end

    def sample(_second : Float64)
      0.0
    end
  end
end
