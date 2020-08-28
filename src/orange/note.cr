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

    def initialize(@duration, @frequency)
    end

    def initialize(@duration, note : String)
      raise "No note" unless NOTE_HZS.has_key?(note)

      @frequency = NOTE_HZS[note]
    end

    def sample(second : Float64)
      return 0.0 if second > @duration

      Math.sin(@frequency * second * 2.0 * Math::PI)
    end
  end

  class Rest < Note
    def initialize(@duration)
      @frequency = 0.0
    end

    def sample(_second : Float64)
      0.0
    end
  end
end
