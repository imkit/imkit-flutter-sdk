// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMLocation _$IMLocationFromJson(Map<String, dynamic> json) => IMLocation(
      address: json['address'] as String? ?? "",
      latitude: json['latitude'] == null ? 0 : toDouble(json['latitude']),
      longitude: json['longitude'] == null ? 0 : toDouble(json['longitude']),
    );

Map<String, dynamic> _$IMLocationToJson(IMLocation instance) =>
    <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
