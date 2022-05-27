import 'package:flutter/material.dart';

class IMStatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const IMStatefulWrapper({Key? key, required this.onInit, required this.child}) : super(key: key);

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
  Widget build(BuildContext context) => widget.child;
}
