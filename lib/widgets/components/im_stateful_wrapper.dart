import 'package:flutter/material.dart';

class IMStatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Function? onDispose;
  final Widget child;
  const IMStatefulWrapper({Key? key, required this.onInit, required this.child, this.onDispose}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IMStatefulWrapperState();
}

class _IMStatefulWrapperState extends State<IMStatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
