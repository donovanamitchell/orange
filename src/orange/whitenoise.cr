module Orange
  class Whitenoise < Note
    def initialize(@duration, @waveform = Waveform::Sine)
      @frequency = 0.0
    end

    def sample(_second : Float64)
      Random.rand
    end
  end
end
