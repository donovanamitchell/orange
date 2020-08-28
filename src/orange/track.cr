module Orange
  class Track
    property notes : Array(Note)

    def initialize
      @notes = [] of Note
    end

    def duration
      @notes.sum { |note| note.duration }
    end

    def samples(seek : Float64, samples : Int, sample_rate : Float64)
      note_index = 0
      previous_note_seconds = 0.0
      note = @notes[note_index]

      Array(Float64).new(samples) do |sample_index|
        note_seconds_elapsed = (sample_index / sample_rate) - previous_note_seconds
        if(note_seconds_elapsed > note.duration && note_index + 1 < @notes.size)
          note_index += 1
          previous_note_seconds += note.duration
          note_seconds_elapsed -= note.duration
          note = @notes[note_index]
        end
        note.sample(note_seconds_elapsed)
      end
    end
  end
end
