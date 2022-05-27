// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'im_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IMLocation _$IMLocationFromJson(Map<String, dynamic> json) => IMLocation(
      address: json['address'] as String? ?? "",
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$IMLocationToJson(IMLocation instance) =>
    <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
