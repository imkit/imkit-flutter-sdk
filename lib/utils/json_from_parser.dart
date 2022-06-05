import 'dart:convert';

DateTime? toDateTime(int? timestamp) => timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch(timestamp);

int? toTimestamp(DateTime? dateTime) => dateTime?.millisecondsSinceEpoch;

Map<String, dynamic>? toMap(dynamic resource) {
  if (resource == null) {
    return null;
  } else if (resource is String) {
    return jsonDecode(resource);
  }
  return resource;
}

List<Map<String, dynamic>>? toList(dynamic resource) {
  if (resource == null) {
    return null;
  } else if (resource is List) {
    return resource.map((element) => toMap(element)!).toList();
  }
  return resource;
}
