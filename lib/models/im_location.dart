import 'package:json_annotation/json_annotation.dart';

part 'im_location.g.dart';

IMLocation deserializeIMLocation(Map<String, dynamic> json) => IMLocation.fromJson(json);
List<IMLocation> deserializeIMLocationList(List<Map<String, dynamic>> json) => json.map((e) => IMLocation.fromJson(e)).toList();

Map<String, dynamic> serializeIMLocation(IMLocation object) => object.toJson();
List<Map<String, dynamic>> serializeIMLocationList(List<IMLocation> objects) => objects.map((e) => e.toJson()).toList();

@JsonSerializable()
class IMLocation {
  @JsonKey(name: 'address')
  String address = "";

  @JsonKey(name: 'latitude')
  double latitude = 0;

  @JsonKey(name: 'longitude')
  double longitude = 0;

  IMLocation({
    this.address = "",
    this.latitude = 0,
    this.longitude = 0,
  });

  factory IMLocation.fromJson(Map<String, dynamic> json) => _$IMLocationFromJson(json);
  Map<String, dynamic> toJson() => _$IMLocationToJson(this);
}
