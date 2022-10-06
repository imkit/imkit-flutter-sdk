import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';

enum IMUtilityType {
  location,
  file,
}

IconData getUtilityIcon({required IMUtilityType type}) {
  switch (type) {
    case IMUtilityType.location:
      return Icons.location_on_outlined;
    case IMUtilityType.file:
      return Icons.description_outlined;
  }
}

String getUtilityText({required IMUtilityType type}) {
  switch (type) {
    case IMUtilityType.location:
      return IMKit.S.n_location;
    case IMUtilityType.file:
      return IMKit.S.n_file;
  }
}
