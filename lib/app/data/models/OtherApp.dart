import 'package:json_annotation/json_annotation.dart';

part 'OtherApp.g.dart';

@JsonSerializable()
class OtherApp {
  final String name;
  final String link;
  final String imageLink;

  OtherApp(
      this.name,
      this.link,
      this.imageLink);

  factory OtherApp.fromJson(Map<String, dynamic> json) =>
      _$OtherAppFromJson(json);

  Map<String, dynamic> toJson() => _$OtherAppToJson(this);
}
