import 'dart:convert';

import 'package:flutter/material.dart';

DateTime? toDateTime(int? timestamp) => timestamp == null ? null : DateTime.fromMillisecondsSinceEpoch(timestamp);

int? toTimestamp(DateTime? dateTime) => dateTime?.millisecondsSinceEpoch;

int toInt(dynamic value) => int.tryParse(value.toString()) ?? 0;

double toDouble(dynamic value) => double.tryParse(value.toString()) ?? 0;

Map<String, dynamic>? toMap(dynamic resource) {
  try {
    if (resource == null) {
      return null;
    } else if (resource is String) {
      return jsonDecode(resource);
    }
    return resource;
  } catch (e) {
    debugPrint(">>> toMap error: ${e.toString()}");
    return null;
  }
}

List<Map<String, dynamic>>? toList(dynamic resource) {
  if (resource == null) {
    return null;
  } else if (resource is List) {
    return resource.map((element) => toMap(element)!).toList();
  }
  return resource;
}
