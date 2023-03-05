import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/utils/toast.dart';
import 'package:photo_manager/photo_manager.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(widget.camera, ResolutionPreset.medium, enableAudio: false);

    _initializeControllerFuture = _controller.initialize();
    Future.delayed(Duration.zero, _requestAssets);
  }

  Future<void> _requestAssets() async {}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(IMKit.S.take_a_picture)),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              Toast.basic(text: "${snapshot.error}", icon: Icons.error);
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop();
              });
              return Container();
            } else {
              if (MediaQuery.of(context).orientation == Orientation.portrait) {
                final mediaSize = MediaQuery.of(context).size;
                final scale = 1 / (_controller.value.aspectRatio * mediaSize.aspectRatio);
                return ClipRect(
                  clipper: _MediaSizeClipper(mediaSize),
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.topCenter,
                    child: CameraPreview(_controller),
                  ),
                );
              } else {
                return Center(child: CameraPreview(_controller));
              }
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if (!mounted) return;
            final AssetEntity result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => DisplayPictureScreen(imagePath: image.path)));
            if (result.relativePath != null) {
              Navigator.of(context).pop(result);
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;

  const _MediaSizeClipper(this.mediaSize);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = Image.file(File(imagePath));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(IMKit.S.preview_picture)),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          image.image.resolve(const ImageConfiguration()).addListener(ImageStreamListener((imageInfo, synchronousCall) {
            AssetEntity assetEntity =
                AssetEntity(id: imagePath, typeInt: 1, width: imageInfo.image.width, height: imageInfo.image.height, relativePath: imagePath);
            Navigator.of(context).pop(assetEntity);
          }));
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
