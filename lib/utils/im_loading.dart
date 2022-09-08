import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class IMLoading {
  static get view => Center(
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
              // Gap(4.h),
              // Text(S.current.action_loading, style: AppTypography.text13)
            ],
          ),
        ),
      );

  static show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) => IMLoading.view,
    );
  }

  static hide(BuildContext context) => Navigator.of(context).pop();
}
