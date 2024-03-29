import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class IMMessageItemComponent {
  static final dateFormat = DateFormat("HH:mm");
  static final dateFormatWith12Hours = DateFormat("a h:mm");

  static bool isPortrait(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait;

  static double getMaxCellWidth(BuildContext context) => MediaQuery.of(context).size.width * 0.7;
  static double getStrickerCellWidth(BuildContext context) => MediaQuery.of(context).size.width * 0.3;

  static double getPreviewCellHeight(BuildContext context) => MediaQuery.of(context).size.height * 0.1;

  static Widget getLoadImageFailure() => Container(
        padding: const EdgeInsets.all(12),
        width: 44,
        height: 44,
        child: const Icon(Icons.broken_image_outlined),
      );
}
