DateTime toDateTime(int timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp);

int? toTimestamp(DateTime? dateTime) => dateTime?.millisecondsSinceEpoch;
