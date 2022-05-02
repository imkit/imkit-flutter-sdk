import 'package:floor/floor.dart';
import 'package:imkit/utils/json_from_parser.dart';

class IMDateTimeConverter extends TypeConverter<DateTime?, int?> {
  @override
  DateTime? decode(int? databaseValue) {
    return toDateTime(databaseValue);
  }

  @override
  int? encode(DateTime? value) {
    return toTimestamp(value);
  }
}
