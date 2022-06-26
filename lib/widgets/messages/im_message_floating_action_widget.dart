import 'package:flutter/material.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';
import 'package:imkit/widgets/messages/im_messages_list_widget.dart';

final GlobalKey<IMMessageFloatingActionWidgetState> floatingActionWidgetKey = GlobalKey();

class IMMessageFloatingActionWidget extends StatefulWidget {
  const IMMessageFloatingActionWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => IMMessageFloatingActionWidgetState();
}

class IMMessageFloatingActionWidgetState extends State<IMMessageFloatingActionWidget> {
  bool _isVisiable = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isVisiable,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.only(bottom: 64),
        child: IMIconButtonWidget(
          size: 35,
          icon: Icon(Icons.vertical_align_bottom, color: Colors.grey[600]),
          onPressed: messagesListWidgetKey.currentState?.jumpToBottom,
        ),
      ),
    );
  }

  void updateStatus(bool isVisiable) {
    if (_isVisiable != isVisiable) {
      setState(() {
        _isVisiable = isVisiable;
      });
    }
  }
}
