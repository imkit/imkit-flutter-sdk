import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';

class IMMessageItemDate extends StatelessWidget {
  final String value;

  const IMMessageItemDate({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: IMKit.style.message.date.backgroundColor,
          borderRadius: BorderRadius.circular(IMKit.style.message.cornerRadius * 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          value,
          style: IMKit.style.message.date.textSytle,
          textAlign: TextAlign.center,
        ),
      );
}
