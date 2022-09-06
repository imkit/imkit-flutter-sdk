import 'package:flutter/material.dart';

class IMKitInputViewStyle {
  final IMKitPhotoInputViewStyle photo = IMKitPhotoInputViewStyle();
  final IMKitRecordInputViewStyle record = IMKitRecordInputViewStyle();
}

class IMKitPhotoInputViewStyle {
  TextStyle numberTextStyle = const TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 14);
}

class IMKitRecordInputViewStyle {
  TextStyle timeTextStyle = const TextStyle(color: Color.fromRGBO(158, 158, 158, 1), fontSize: 16);
}
