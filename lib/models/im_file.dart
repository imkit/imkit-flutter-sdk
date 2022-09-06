import 'package:json_annotation/json_annotation.dart';

part 'im_file.g.dart';

IMFile deserializeIMFile(Map<String, dynamic> json) => IMFile.fromJson(json);
List<IMFile> deserializeIMFileList(List<Map<String, dynamic>> json) => json.map((e) => IMFile.fromJson(e)).toList();

Map<String, dynamic> serializeIMFile(IMFile object) => object.toJson();
List<Map<String, dynamic>> serializeIMFileList(List<IMFile> objects) => objects.map((e) => e.toJson()).toList();

@JsonSerializable()
class IMFile {
  @JsonKey(name: 'url', defaultValue: null)
  String? url;

  @JsonKey(name: 'name', defaultValue: null)
  String? name;

  @JsonKey(name: 'fileExtension', defaultValue: null)
  String? fileExtension;

  @JsonKey(name: 'mimeType', defaultValue: null)
  String? mimeType;

  @JsonKey(name: 'bytes')
  int bytes = 0;

  @JsonKey(name: 'duration')
  int duration = 0;

  String get filename => "${name ?? ""}.${fileExtension ?? ""}";

  IMFile({
    this.url,
    this.name,
    this.fileExtension,
    this.mimeType,
    this.bytes = 0,
    this.duration = 0,
  });

  factory IMFile.fromJson(Map<String, dynamic> json) => _$IMFileFromJson(json);
  Map<String, dynamic> toJson() => _$IMFileToJson(this);
}
