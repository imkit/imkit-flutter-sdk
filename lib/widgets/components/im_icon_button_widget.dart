import 'package:flutter/material.dart';

class IMIconButtonWidget extends StatelessWidget {
  const IMIconButtonWidget({
    Key? key,
    required this.icon,
    this.onPressed,
    this.size = 36,
    this.iconSize = 24,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final Function()? onPressed;
  final Icon icon;
  final double size;
  final double iconSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: IconButton(
          enableFeedback: false,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: onPressed,
          padding: padding,
          icon: icon,
          iconSize: iconSize,
        ),
      );
}
