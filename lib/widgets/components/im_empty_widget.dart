import 'package:flutter/material.dart';
import 'package:imkit/gen/assets.gen.dart';
import 'package:imkit/imkit_sdk.dart';

class IMEmptyWidget extends StatelessWidget {
  final AssetGenImage icon;
  final String message;
  const IMEmptyWidget({Key? key, required this.icon, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.image(width: 180, package: IMKit.instance.internal.state.sdkDefaultPackageName),
            const SizedBox(height: 10),
            Text(message, style: IMKit.style.room.emptyTitle),
          ],
        ),
      );
}
