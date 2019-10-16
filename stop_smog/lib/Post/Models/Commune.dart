import 'package:json_annotation/json_annotation.dart';
part 'Commune.g.dart';
@JsonSerializable()
class Commune {
  final String communeName;
  final String districtName;
  final String provinceName;

  Commune({this.communeName, this.districtName, this.provinceName});


  factory Commune.fromJson(Map<String, dynamic> json) => _$CommuneFromJson(json);
  Map<String, dynamic> toJson() => _$CommuneToJson(this);
}