import 'package:imkit/sdk/imkit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_upload_file.g.dart';

IMUploadFile deserializeIMUploadFile(Map<String, dynamic> json) => IMUploadFile.fromJson(json);

@JsonSerializable()
class IMUploadFile {
  @JsonKey(name: '_id', defaultValue: '')
  String id = "";

  @JsonKey(name: 'bucketName', defaultValue: '')
  String bucketName = "";

  String get url {
    return "${IMKit.instance.internal.state.chatServerURL}/files/$bucketName/$id";
  }

  IMUploadFile({
    required this.id,
    required this.bucketName,
  });

  factory IMUploadFile.fromJson(Map<String, dynamic> json) => _$IMUploadFileFromJson(json);
  Map<String, dynamic> toJson() => _$IMUploadFileToJson(this);
}
