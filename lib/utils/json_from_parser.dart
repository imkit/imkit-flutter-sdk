DateTime? toDateTime(int? timestamp) => timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch(timestamp);

int? toTimestamp(DateTime? dateTime) => dateTime?.millisecondsSinceEpoch;
