import 'package:audioplayers/audioplayers.dart' as ap;

class AudioPlayerManager {
  static final AudioPlayerManager instance = AudioPlayerManager._();
  ap.AudioPlayer? _audioPlayer;
  AudioPlayerManager._();

  void play({required ap.AudioPlayer player, required ap.Source source}) async {
    if (_audioPlayer != null) {
      await _audioPlayer?.stop();
      _audioPlayer = null;
    }
    _audioPlayer = player;
    _audioPlayer?.play(source);
  }
}
