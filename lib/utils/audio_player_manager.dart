import 'package:audioplayers/audioplayers.dart' as ap;

class AudioPlayerManager {
  static final AudioPlayerManager instance = AudioPlayerManager._();
  final ap.AudioContext _audioContext = ap.AudioContext(
    iOS: ap.AudioContextIOS(
      defaultToSpeaker: true,
      category: ap.AVAudioSessionCategory.ambient,
      options: [
        ap.AVAudioSessionOptions.defaultToSpeaker,
        ap.AVAudioSessionOptions.mixWithOthers,
      ],
    ),
    android: ap.AudioContextAndroid(
      isSpeakerphoneOn: true,
      stayAwake: true,
      contentType: ap.AndroidContentType.sonification,
      usageType: ap.AndroidUsageType.assistanceSonification,
      audioFocus: ap.AndroidAudioFocus.none,
    ),
  );

  ap.AudioPlayer? _audioPlayer;
  AudioPlayerManager._() {
    ap.AudioPlayer.global.setGlobalAudioContext(_audioContext);
  }

  void play({required ap.AudioPlayer player, required ap.Source source}) async {
    if (_audioPlayer != null) {
      await _audioPlayer?.stop();
      _audioPlayer = null;
    }
    _audioPlayer = player;
    _audioPlayer?.play(source);
  }
}
