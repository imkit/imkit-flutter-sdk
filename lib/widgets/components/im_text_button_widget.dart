import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';

class IMTextButtonWidget extends StatelessWidget {
  const IMTextButtonWidget({
    Key? key,
    required this.text,
    this.height = 44,
    this.onTap,
  }) : super(key: key);

  final String text;
  final double height;
  final Function? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => onTap?.call(),
        child: Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: IMKit.style.button.backgroundColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Text(text, style: IMKit.style.button.text),
        ),
      );
}
