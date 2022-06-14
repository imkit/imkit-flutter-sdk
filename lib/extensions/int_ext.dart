import 'package:intl/intl.dart';

extension IntExtension on int {
  String get toTime {
    final milliseconds = DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);
    final format = this >= 3600 ? "HH:mm:ss" : "mm:ss";

    return DateFormat(format).format(milliseconds);
  }
}
