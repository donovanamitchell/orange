module Orange
  class Note
    NOTE_HZS = {
      "A" => 440.00,
      "B" => 493.88,
      "C" => 523.25,
      "D" => 587.33,
      "E" => 659.25,
      "F" => 698.46,
      "G" => 783.99,
    }

    property duration : Float64
    property frequency : Float64
    property waveform : Waveform

    def initialize(@duration, @frequency, @waveform = Waveform::Sine)
    end

    def initialize(@duration, note : String, @waveform = Waveform::Sine)
      raise "No note" unless NOTE_HZS.has_key?(note)

      @frequency = NOTE_HZS[note]
    end

    def sample(second : Float)
      return 0.0 if second > @duration

      case @waveform
      when .sawtooth?
        sample_sawtooth(second)
      when .sine?
        sample_sine(second)
      when .square?
        sample_square(second)
      when .triangle?
        sample_triangle(second)
      else
        0.0
      end
    end

    def sample_sawtooth(second : Float64)
      2.0 * @frequency * (second % (1.0 / @frequency)) - 1.0
    end

    def sample_sine(second : Float64)
      Math.sin(@frequency * second * 2.0 * Math::PI)
    end

    def sample_square(second : Float64)
      second % (1.0 / @frequency) > 0.5 / @frequency ? 1.0 : -1.0
    end

    def sample_triangle(second : Float64)
      1 - ((4 * @frequency * (second % (1.0 / @frequency)) - 2)).abs
    end
  end
end
