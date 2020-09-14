require "./src/orange"
require "crsfml"
require "crsfml/system"
require "crsfml/audio"

module Orange
  # Example 0 - Note

  a = Note.new(duration: 1.0, frequency: 440.0)

  sample_count = 44100
  sample_rate = 44100
  amplitude = 0.125

  scaled_amplitude = (amplitude * Int16::MAX)
  samples = Slice(Int16).new(sample_count) do |index|
    (a.sample(index / sample_rate) * scaled_amplitude).to_i16
  end

  sound_buffer_0 = SF::SoundBuffer.from_samples(samples, 1, sample_rate)
  sound_0 = SF::Sound.new(sound_buffer_0)

  sound_buffer_0.save_to_file("./tmp/sound_0.wav")

  # Example 1 - Track

  a = Note.new(duration: 0.125, note: "A4")
  b = Note.new(duration: 0.125, note: "B4")
  c = Note.new(duration: 0.125, note: "C5")
  d = Note.new(duration: 0.125, note: "D5")
  e = Note.new(duration: 0.125, note: "E5")
  f = Note.new(duration: 0.125, note: "F5")
  g = Note.new(duration: 0.125, note: "G5")

  track = Track.new
  track.notes = [a, b, c, d, e, f, g]
  sample_count = (44100 * track.duration).to_i
  sample_rate = 44100
  amplitude = 0.125

  track_samples = track.samples(0.0, sample_count, sample_rate)

  scaled_amplitude = (amplitude * Int16::MAX)
  samples = Slice(Int16).new(sample_count) do |index|
    (track_samples[index] * scaled_amplitude).to_i16
  end

  sound_buffer_1 = SF::SoundBuffer.from_samples(samples, 1, sample_rate)
  sound_1 = SF::Sound.new(sound_buffer_1)

  sound_buffer_1.save_to_file("./tmp/sound_1.wav")

  # Example 2 - Song

  amplitude = 0.125
  sample_rate = 44100

  a_track = Track.new
  a_track.notes << Note.new(duration: 8.0, note: "A4")

  b_track = Track.new
  b_track.notes << Note.new(duration: 7.0, note: "B4")

  c_track = Track.new
  c_track.notes << Note.new(duration: 6.0, note: "C5")

  d_track = Track.new
  d_track.notes << Note.new(duration: 5.0, note: "D5")

  e_track = Track.new
  e_track.notes << Note.new(duration: 4.0, note: "E5")

  f_track = Track.new
  f_track.notes << Note.new(duration: 3.0, note: "F5")

  g_track = Track.new
  g_track.notes << Note.new(duration: 2.0, note: "G5")

  song = Song.new
  song.tracks << a_track
  song.append_track(b_track, 1.0)
  song.append_track(c_track, 2.0)
  song.append_track(d_track, 3.0)
  song.append_track(e_track, 4.0)
  song.append_track(f_track, 5.0)
  song.append_track(g_track, 6.0)

  sample_count = (song.duration * 44100).to_i
  samples = song.samples(0.0, sample_count, sample_rate, amplitude)

  sound_buffer_2 = SF::SoundBuffer.from_samples(samples, 1, sample_rate)
  sound_2 = SF::Sound.new(sound_buffer_2)

  sound_buffer_2.save_to_file("./tmp/sound_2.wav")

  # Example 3 - Waveforms
  amplitude = 0.125
  sample_rate = 44100

  sine_a = Note.new(duration: 1.0, note: "A4", waveform: Waveforms::Sine)
  sawtooth_a = Note.new(duration: 1.0, note: "A4", waveform: Waveforms::Sawtooth)
  square_a = Note.new(duration: 1.0, note: "A4", waveform: Waveforms::Square)
  triangle_a = Note.new(duration: 1.0, note: "A4", waveform: Waveforms::Triangle)
  whitenoise = Note.new(duration: 1.0, note: "A4", waveform: Waveforms::Whitenoise)
  rest = Rest.new(0.125)

  track = Track.new
  track.notes = [sine_a, rest, sawtooth_a, rest, square_a, rest, triangle_a, rest, whitenoise]
  song = Song.new
  song.tracks = [track]

  sample_count = (song.duration * 44100).to_i
  samples = song.samples(0.0, sample_count, sample_rate, amplitude)

  sound_buffer_3 = SF::SoundBuffer.from_samples(samples, 1, sample_rate)
  sound_3 = SF::Sound.new(sound_buffer_3)

  sound_buffer_3.save_to_file("./tmp/sound_3.wav")

  # Example 4 - Envelope
  amplitude = 0.125
  sample_rate = 44100

  rest = Rest.new(0.125)

  waveforms = [
    Waveforms::Sine,
    Waveforms::Sawtooth,
    Waveforms::Square,
    Waveforms::Triangle,
    Waveforms::Whitenoise,
  ]
  envelopes = [
    Envelopes::None.new,
    Envelopes::Adsr.new(
      attack_amplitude: 1.25,
      attack_time: 0.125,
      decay_time: 0.125,
      release_time: 0.125
    ),
  ]

  track = Track.new

  waveforms.each do |wave|
    envelopes.each do |envelope|
      track.notes << Note.new(
        duration: 1.0,
        envelope: envelope,
        waveform: wave,
        frequency: 440.0
      )
      track.notes << rest
    end
  end
  song = Song.new
  song.tracks = [track]

  sample_count = (song.duration * 44100).to_i
  samples = song.samples(0.0, sample_count, sample_rate, amplitude)

  sound_buffer_4 = SF::SoundBuffer.from_samples(samples, 1, sample_rate)
  sound_buffer_4.save_to_file("./tmp/sound_4.wav")
end
