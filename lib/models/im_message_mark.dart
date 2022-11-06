import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'im_message_mark.g.dart';

@JsonSerializable()
@Entity()
class IMMessageMark {
  @PrimaryKey()
  String id = "";

  bool isDelete = false;

  IMMessageMark({
    required this.id,
    this.isDelete = false,
  });
}
