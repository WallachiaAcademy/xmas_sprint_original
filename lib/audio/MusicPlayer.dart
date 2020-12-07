import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:xmas_sprint/data/UserData.dart';

MusicPlayer musicPlayer = MusicPlayer();

class MusicPlayer {
  bool _musicIsPlaying = false;
  AudioPlayer _player = null;

  Future<void> update() async {
    try {
      Flame.audio.disableLog();
      if (_musicIsPlaying) {
        if (!userData.shallPlayMusic()) {
          _musicIsPlaying = false;
          if (_player != null) {
            _player.stop();
          }
        }
      }
      if (!_musicIsPlaying) {
        if (userData.shallPlayMusic()) {
          _musicIsPlaying = true;
          _player = await Flame.audio.playLongAudio('song.ogg');
          _player.setReleaseMode(ReleaseMode.LOOP);
        } else {
          if (_player != null) {
            _player.stop();
          }
        }
      }
    } catch (Exception) {}
  }

  Future<void> candyDie() async {
    try {
      if (userData.shallPlaySong()) {
        await Flame.audio.play('breaking.ogg');
      }
    } catch (Exception) {}
  }

  Future<void> santaDie() async {
    try {
      if (userData.shallPlaySong()) {
        await Flame.audio.play('santa.wav');
      }
    } catch (Exception) {}
  }

  void resume() {
    try {
      if (userData.shallPlayMusic() && _player != null) _player.resume();
    } catch (Exception) {}
  }

  void pause() {
    try {
      if (userData.shallPlayMusic() && _player != null) _player.pause();
    } catch (Exception) {}
  }
}
