import 'package:flutter/material.dart';

class IMCircleButtonWidget extends StatelessWidget {
  const IMCircleButtonWidget({
    Key? key,
    required this.child,
    this.onPressed,
    this.color,
    this.disabledColor,
    this.size = 36,
  }) : super(key: key);

  final Function()? onPressed;
  final Color? color;
  final Color? disabledColor;
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: MaterialButton(
          color: color,
          disabledColor: color ?? disabledColor,
          enableFeedback: false,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          shape: const CircleBorder(),
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          child: child,
        ),
      );
}
