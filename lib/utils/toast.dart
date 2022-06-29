import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class Toast {
  static basic({required String text, IconData? icon}) => SmartDialog.show(
        displayTime: const Duration(seconds: 2),
        builder: (context) => Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.54),
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: icon != null,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      );
}
