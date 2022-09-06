import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:flutter/material.dart';
import 'package:imkit/models/im_message.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/utils/utils.dart';
import 'package:imkit/widgets/components/im_stateful_wrapper.dart';
import 'package:imkit/widgets/messages/items/im_message_item_audio_upload.dart';

class IMMessageItemAudio extends StatelessWidget {
  final IMMessage message;
  final _audioPlayer = ap.AudioPlayer();

  IMMessageItemAudio({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (message.status) {
      case IMMessageStatus.sent:
        return _buildFromLocal(message: message);

      default:
        return _buildFromUrl(message: message);
    }
  }
}

extension on IMMessageItemAudio {
  Widget _buildFromUrl({required IMMessage message}) => IMStatefulWrapper(
        onInit: () {
          // inspect(message);
        },
        onDispose: () {
          _audioPlayer.dispose();
        },
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            // if (_audioPlayer.state == ap.PlayerState.playing) {
            //   _audioPlayer.pause();
            // } else {
            //   final file = message.file;
            //   if (file != null && (file.url ?? "").isNotEmpty) {
            //     IMKit.instance.action
            //         .downloadFileToCache(url: file.url!, filename: file.filename)
            //         .then((value) => _audioPlayer.play(ap.DeviceFileSource(value.path)));
            //   }
            // }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: StreamBuilder<Duration>(
              stream: _audioPlayer.onPositionChanged,
              builder: (context, snapshot) {
                final total = Duration(seconds: message.file?.duration ?? 0);
                final diff = total - (snapshot.data ?? const Duration(seconds: 0));
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _audioPlayer.state == ap.PlayerState.playing ? Icons.pause_circle_filled_outlined : Icons.play_circle_fill_outlined,
                      size: 28,
                      color: IMKit.style.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      Utils.formatDuration(diff.inSeconds),
                      style: message.isMe ? IMKit.style.message.outgoing.textSytle : IMKit.style.message.incoming.textSytle,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );

  Widget _buildFromLocal({required IMMessage message}) => IMMessageItemAudioUpload(message: message);
}
