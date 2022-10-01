import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/utils/audio_player_manager.dart';
import 'package:imkit/utils/utils.dart';
import 'package:imkit/widgets/components/im_stateful_wrapper.dart';

class IMMessageItemAudioUrl extends StatelessWidget {
  final IMMessage message;
  final ap.AudioPlayer _audioPlayer = ap.AudioPlayer();
  final List<StreamSubscription> _streams = [];

  IMMessageItemAudioUrl({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => IMStatefulWrapper(
        onInit: () {
          _streams.add(_audioPlayer.onPlayerComplete.listen((event) {
            _audioPlayer.state = ap.PlayerState.completed;
          }));
        },
        onDispose: () {
          _streams.map((it) => it.cancel());
          _audioPlayer.dispose();
        },
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            if (_audioPlayer.state == ap.PlayerState.playing) {
              _audioPlayer.stop();
            } else {
              final file = message.file;
              if (file != null && (file.url ?? "").isNotEmpty) {
                IMKit.instance.action
                    .downloadFileToCache(url: file.url!, filename: file.filename)
                    .then((value) => AudioPlayerManager.instance.play(player: _audioPlayer, source: ap.DeviceFileSource(value.path)));
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder<ap.PlayerState>(
                  stream: _audioPlayer.onPlayerStateChanged,
                  builder: (context, snapshot) => Icon(
                    snapshot.data == ap.PlayerState.playing ? Icons.pause_circle_filled_outlined : Icons.play_circle_fill_outlined,
                    size: 28,
                    color: IMKit.style.primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                StreamBuilder<Duration>(
                  stream: _audioPlayer.onPositionChanged,
                  builder: (context, snapshot) {
                    final total = Duration(seconds: message.file?.duration ?? 0);
                    final diff = total - (snapshot.data ?? const Duration(seconds: 0));
                    return SizedBox(
                      width: 50,
                      child: Text(
                        Utils.formatDuration(diff.inSeconds),
                        textAlign: TextAlign.center,
                        style: message.isMe ? IMKit.style.message.outgoing.textSytle : IMKit.style.message.incoming.textSytle,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
