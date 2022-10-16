import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class IMLoading {
  static show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) => Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xB3000000),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 52,
                height: 52,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballSpinFadeLoader,
                  colors: [Colors.white],
                  strokeWidth: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static hide(BuildContext context) => Navigator.of(context).pop();

  static Future<T> exec<T>({required BuildContext context, required Future<T> future}) async {
    IMLoading.show(context);
    try {
      return await future;
    } finally {
      IMLoading.hide(context);
    }
  }
}
