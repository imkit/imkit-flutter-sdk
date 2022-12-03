import 'package:flutter/material.dart';

class IMKitInputViewStyle {
  final IMKitPhotoInputViewStyle photo = IMKitPhotoInputViewStyle();
  final IMKitRecordInputViewStyle record = IMKitRecordInputViewStyle();
  final IMKitUtilityInputViewStyle utility = IMKitUtilityInputViewStyle();
}

class IMKitPhotoInputViewStyle {
  TextStyle numberTextStyle = const TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 14);
}

class IMKitRecordInputViewStyle {
  TextStyle timeTextStyle = const TextStyle(color: Color.fromRGBO(158, 158, 158, 1), fontSize: 16);
}

class IMKitUtilityInputViewStyle {
  Color iconColor = const Color.fromRGBO(120, 120, 120, 1);
  Color iconActiveColor = const Color.fromRGBO(60, 60, 60, 1);
  Color iconInactiveColor = const Color.fromRGBO(180, 180, 180, 1);

  TextStyle textTextStyle = const TextStyle(color: Color.fromRGBO(117, 117, 117, 1), fontSize: 12);
}
