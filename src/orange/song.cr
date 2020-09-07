module Orange
  class Song
    property tracks : Array(Track)

    def initialize
      @tracks = [] of Track
    end

    def duration
      @tracks.max_by { |track| track.duration }.duration
    end

    def append_track(track, start_seconds = 0.0)
      track.notes.unshift(Rest.new(start_seconds))
      end_rest_length = duration - track.duration
      track.notes << Rest.new(end_rest_length) if end_rest_length > 0

      @tracks << track
    end

    def samples(seek : Float64, samples : Int, sample_rate : Int, amplitude)
      scaled_amplitude = (amplitude * Int16::MAX)

      track_samples = @tracks.map do |track|
        track.samples(seek, samples, sample_rate)
      end

      Slice(Int16).new(samples) do |index|
        (track_samples.sum { |track| track[index] } * scaled_amplitude).to_i16!
      end
    end
  end
end