# https://oprypin.github.io/crsfml/tutorials/audio/streams.html
# https://www.joelstrait.com/nanosynth/
# D:\Programs\pulseaudio-1.1\bin\pulseaudio.exe

require "crsfml"
require "crsfml/system"
require "crsfml/audio"
require "./orange/*"

module Orange
  VERSION = "0.1.0"

  # Example 0

  a = Note.new(1.0, "A")

  sample_count = 44100
  sample_rate = 44100
  amplitude = 0.125

  scaled_amplitude = (amplitude * Int16::MAX)
  samples = Slice(Int16).new(sample_count) do |index|
    (a.sample(index / sample_rate) * scaled_amplitude).to_i16
  end

  sound_buffer_0 = SF::SoundBuffer.from_samples(samples, 1, sample_rate)
  sound_0 = SF::Sound.new(sound_buffer_0)

  sound_buffer_0.save_to_file("./sound_0.wav")

  # Example 1

  a = Note.new(0.125, "A")
  b = Note.new(0.125, "B")
  c = Note.new(0.125, "C")
  d = Note.new(0.125, "D")
  e = Note.new(0.125, "E")
  f = Note.new(0.125, "F")
  g = Note.new(0.125, "G")

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

  sound_buffer_1.save_to_file("./sound_1.wav")

  # Example 2

  amplitude = 0.125
  sample_rate = 44100

  a_track = Track.new
  a_track.notes << Note.new(8.0, "A")

  b_track = Track.new
  b_track.notes << Note.new(7.0, "B")

  c_track = Track.new
  c_track.notes << Note.new(6.0, "C")

  d_track = Track.new
  d_track.notes << Note.new(5.0, "D")

  e_track = Track.new
  e_track.notes << Note.new(4.0, "E")

  f_track = Track.new
  f_track.notes << Note.new(3.0, "F")

  g_track = Track.new
  g_track.notes << Note.new(2.0, "G")

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

  sound_buffer_2.save_to_file("./sound_2.wav")

  # Example 3
  amplitude = 0.125
  sample_rate = 44100

  sine_a = Note.new(1.0, "A", Waveform::Sine)
  sawtooth_a = Note.new(1.0, "A", Waveform::Sawtooth)
  square_a = Note.new(1.0, "A", Waveform::Square)
  triangle_a = Note.new(1.0, "A", Waveform::Triangle)
  rest = Rest.new(0.125)

  track = Track.new
  track.notes = [sine_a, rest, sawtooth_a, rest, square_a, rest, triangle_a]
  song = Song.new
  song.tracks = [track]

  sample_count = (song.duration * 44100).to_i
  samples = song.samples(0.0, sample_count, sample_rate, amplitude)

  sound_buffer_3 = SF::SoundBuffer.from_samples(samples, 1, sample_rate)
  sound_3 = SF::Sound.new(sound_buffer_3)

  sound_buffer_3.save_to_file("./sound_3.wav")

  # Example 4
  amplitude = 0.125
  sample_rate = 44100

  track = Track.new
  track.notes << Whitenoise.new(1.0)
  song = Song.new
  song.tracks = [track]

  sample_count = (song.duration * 44100).to_i
  samples = song.samples(0.0, sample_count, sample_rate, amplitude)

  sound_buffer_4 = SF::SoundBuffer.from_samples(samples, 1, sample_rate)

  sound_buffer_4.save_to_file("./sound_4.wav")
end
