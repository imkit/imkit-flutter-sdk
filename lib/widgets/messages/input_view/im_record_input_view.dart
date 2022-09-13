import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imkit/gen/assets.gen.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/utils/utils.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';
import 'package:record/record.dart';

class IMRecordInputView extends StatefulWidget {
  final Function(String path, int duration) onRecordFinish;
  const IMRecordInputView({Key? key, required this.onRecordFinish}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IMRecordInputViewState();
}

class _IMRecordInputViewState extends State<IMRecordInputView> {
  late int _recordDuration = 0;
  late final _audioRecorder = Record();
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: IMMessageItemComponent.isPortrait(context) ? 250 : 170,
        child: _buildBody(context),
      );

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}

extension on _IMRecordInputViewState {
  void recordStart() async {
    await _audioRecorder.start();
    _startTimer();
  }

  void recordStop() async {
    final _tmpRecordDuration = _recordDuration;
    _timer?.cancel();
    _recordDuration = 0;

    final path = (await _audioRecorder.stop()) ?? "";
    if (path.isNotEmpty) {
      widget.onRecordFinish(path, _tmpRecordDuration);
    }
  }

  void recordCancel() async {
    _timer?.cancel();
    _recordDuration = 0;
    final path = (await _audioRecorder.stop()) ?? "";
    if (path.isNotEmpty) {
      await File(path).delete();
    }
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20),
          Text(Utils.formatDuration(_recordDuration), style: IMKit.style.inputView.record.timeTextStyle),
          const SizedBox(height: 10),
          GestureDetector(
            onLongPressDown: ((details) async {
              debugPrint("onLongPressDown");
              recordStart();
            }),
            onLongPressEnd: (details) async {
              debugPrint("onLongPressEnd globalPosition:" + details.globalPosition.toString());
              debugPrint("onLongPressEnd localPosition:" + details.localPosition.toString());
              debugPrint("onLongPressEnd velocity:" + details.velocity.toString());
              recordStop();
            },
            onLongPressCancel: () {
              debugPrint("onLongPressCancel");
              recordCancel();
            },
            child: Assets.images.reocrdNormal.image(width: 276, package: IMKit.instance.internal.state.sdkDefaultPackageName),
          ),
        ],
      ),
    );
  }
}
