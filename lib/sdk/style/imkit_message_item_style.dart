import 'package:flutter/material.dart';

class IMKitMessageItemStyle {
  final IMKitMessageItemOutgoingStyle outgoing = IMKitMessageItemOutgoingStyle();
  final IMKitMessageItemIncomingStyle incoming = IMKitMessageItemIncomingStyle();
  final IMKitMessageItemSystemStyle system = IMKitMessageItemSystemStyle();
  final IMKitMessageItemDateStyle date = IMKitMessageItemDateStyle();
  final IMKitMessageItemStatusStyle status = IMKitMessageItemStatusStyle();

  double cornerRadius = 12;

  TextStyle readReceiptTextSytle = const TextStyle(color: Color.fromRGBO(189, 189, 189, 1), fontSize: 10);
  TextStyle timeTextSytle = const TextStyle(color: Color.fromRGBO(189, 189, 189, 1), fontSize: 10);
}

class IMKitMessageItemOutgoingStyle {
  Color backgroundColor = const Color.fromRGBO(227, 246, 255, 1);

  TextStyle textSytle = const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 14);
}

class IMKitMessageItemIncomingStyle {
  Color backgroundColor = const Color.fromRGBO(255, 255, 255, 1);

  TextStyle nameTextSytle = const TextStyle(color: Color.fromRGBO(189, 189, 189, 1), fontSize: 10);
  TextStyle textSytle = const TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 14);
}

class IMKitMessageItemSystemStyle {
  Color backgroundColor = const Color.fromRGBO(0, 0, 0, 0.15);

  TextStyle textSytle = const TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 12);
}

class IMKitMessageItemDateStyle {
  Color backgroundColor = const Color.fromRGBO(255, 255, 255, 0.6);

  TextStyle textSytle = const TextStyle(color: Color.fromRGBO(123, 146, 173, 1), fontSize: 11);
}

class IMKitMessageItemStatusStyle {
  Color retryButtonBackgroundColor = const Color.fromRGBO(0, 160, 230, 1);
  Color retryButtonColor = const Color.fromRGBO(255, 255, 255, 1);
}
