import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/models/im_image.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';
import 'package:imkit/widgets/components/im_image_widget.dart';
import 'package:imkit/widgets/messages/items/im_message_item_component.dart';

class IMMessageItemImageUpload extends StatefulWidget {
  final bool isNeedToUpload;
  final IMImage image;
  final Function(Future<IMImage>) callback;
  const IMMessageItemImageUpload({Key? key, required this.isNeedToUpload, required this.image, required this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IMMessageItemImageUploadState();
}

class IMMessageItemImageUploadState extends State<IMMessageItemImageUpload> {
  final CancelToken _cancelToken = CancelToken();
  late double _progress = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      widget.callback(
        IMKit.instance.action.uploadImage(
            image: widget.image,
            uploadProgress: (progress) {
              if (mounted && widget.isNeedToUpload) {
                setState(() {
                  _progress = progress;
                });
              }
            },
            cancelToken: _cancelToken),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          IMImageWidget(
            localPath: widget.image.thumbnailPath,
            fit: BoxFit.cover,
            width: widget.image.width.toDouble(),
            height: widget.image.width <= 0 || widget.image.height <= 0
                ? null
                : IMMessageItemComponent.getMaxCellWidth(context) * widget.image.height / widget.image.width,
            maxWidthDiskCache: IMMessageItemComponent.getMaxCellWidth(context).toInt(),
          ),
          Visibility(
            visible: _progress > 0 && _progress < 1,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    color: IMKit.style.primaryColor,
                    value: _progress,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _progress > 0 && _progress < 1,
            child: IMIconButtonWidget(
              size: 28,
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: _cancelToken.cancel,
            ),
          ),
        ],
      );
}
