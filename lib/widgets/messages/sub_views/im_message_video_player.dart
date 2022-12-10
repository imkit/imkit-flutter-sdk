import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class IMMessageVideoPlayer extends StatefulWidget {
  final IMMessage message;

  const IMMessageVideoPlayer({Key? key, required this.message}) : super(key: key);

  @override
  _IMMessageVideoPlayerState createState() => _IMMessageVideoPlayerState();
}

class _IMMessageVideoPlayerState extends State<IMMessageVideoPlayer> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    final file = widget.message.file;
    if (file != null) {
      IMKit.instance.action
          .downloadFileToCache(url: file.url ?? "", filename: "${widget.message.id}.${file.fileExtension?.toLowerCase()}")
          .then((value) => VideoPlayerController.file(value))
          .then((controller) => controller.initialize().then((value) => controller))
          .then((controller) {
        _controller = controller;
        _controller?.addListener(() {
          setState(() {});
        });
        _controller?.play();
      }).catchError((error) {
        debugPrint(">>> Video Player Error: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Column(children: [
            Text(
              widget.message.sender?.nickname ?? "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Visibility(
              visible: widget.message.createdAt != null,
              child: Text(
                DateFormat("yyyy/MM/dd a hh:mm:ss").format(widget.message.createdAt ?? DateTime.now()),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ]),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.3),
        ),
        body: Center(child: buildBody()),
      );

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}

extension on _IMMessageVideoPlayerState {
  Widget buildBody() {
    final ctrl = _controller;
    if (ctrl == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    return InkWell(
      onTap: () {
        if (ctrl.value.isPlaying) {
          ctrl.pause();
        } else {
          ctrl.play();
        }
      },
      child: AspectRatio(
        aspectRatio: aspectRatio(ctrl: ctrl),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(ctrl),
            Visibility(
              visible: !ctrl.value.isPlaying,
              child: Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_fill_outlined,
                    size: 44,
                    color: IMKit.style.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double aspectRatio({required VideoPlayerController ctrl}) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final value = ctrl.value;
    final size = value.size;
    if (!value.isInitialized || size.width == 0 || size.height == 0) {
      return 1.0;
    }
    final double aspectRatio = isPortrait ? size.width / size.height : size.height / size.width;
    if (aspectRatio <= 0) {
      return 1.0;
    }
    return aspectRatio;
  }
}
