import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day && tomorrow.month == month && tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  bool get isThisYear {
    final now = DateTime.now();
    return now.year == year;
  }

  bool get isSameWeek {
    final now = DateTime.now();
    return now.weekOfYear == weekOfYear;
  }

  int get weekOfYear {
    final woy = ((ordinalDate - weekday + 10) ~/ 7);

    if (woy == 0) {
      return DateTime(year - 1, 12, 28).weekOfYear;
    }

    if (woy == 53 && DateTime(year, 1, 1).weekday != DateTime.thursday && DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }

    return woy;
  }

  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  String get toHumanString {
    if (isToday) {
      return DateFormat("a h:mm").format(this);
    } else if (isYesterday) {
      // I18n
      return "n.yesterday";
    } else if (isSameWeek) {
      return DateFormat("EEEE").format(this);
    } else if (isThisYear) {
      return DateFormat("M/dd").format(this);
    } else {
      return DateFormat("yyyy/M/dd").format(this);
    }
  }
}
