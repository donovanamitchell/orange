require "./src/orange"
require "crsfml"
require "crsfml/system"
require "crsfml/audio"

module Orange
  # Example 0

  a = Note.new(1.0, "A4")

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

  # Example 1

  a = Note.new(0.125, "A4")
  b = Note.new(0.125, "B4")
  c = Note.new(0.125, "C5")
  d = Note.new(0.125, "D5")
  e = Note.new(0.125, "E5")
  f = Note.new(0.125, "F5")
  g = Note.new(0.125, "G5")

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

  # Example 2

  amplitude = 0.125
  sample_rate = 44100

  a_track = Track.new
  a_track.notes << Note.new(8.0, "A4")

  b_track = Track.new
  b_track.notes << Note.new(7.0, "B4")

  c_track = Track.new
  c_track.notes << Note.new(6.0, "C5")

  d_track = Track.new
  d_track.notes << Note.new(5.0, "D5")

  e_track = Track.new
  e_track.notes << Note.new(4.0, "E5")

  f_track = Track.new
  f_track.notes << Note.new(3.0, "F5")

  g_track = Track.new
  g_track.notes << Note.new(2.0, "G5")

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

  # Example 3
  amplitude = 0.125
  sample_rate = 44100

  sine_a = Note.new(1.0, "A4", Waveform::Sine)
  sawtooth_a = Note.new(1.0, "A4", Waveform::Sawtooth)
  square_a = Note.new(1.0, "A4", Waveform::Square)
  triangle_a = Note.new(1.0, "A4", Waveform::Triangle)
  rest = Rest.new(0.125)

  track = Track.new
  track.notes = [sine_a, rest, sawtooth_a, rest, square_a, rest, triangle_a]
  song = Song.new
  song.tracks = [track]

  sample_count = (song.duration * 44100).to_i
  samples = song.samples(0.0, sample_count, sample_rate, amplitude)

  sound_buffer_3 = SF::SoundBuffer.from_samples(samples, 1, sample_rate)
  sound_3 = SF::Sound.new(sound_buffer_3)

  sound_buffer_3.save_to_file("./tmp/sound_3.wav")

  # Example 4
  amplitude = 0.125
  sample_rate = 44100

  track = Track.new
  track.notes << Note.new(1.0, 0.0, Waveform::Whitenoise)
  song = Song.new
  song.tracks = [track]

  sample_count = (song.duration * 44100).to_i
  samples = song.samples(0.0, sample_count, sample_rate, amplitude)

  sound_buffer_4 = SF::SoundBuffer.from_samples(samples, 1, sample_rate)

  sound_buffer_4.save_to_file("./tmp/sound_4.wav")
end
