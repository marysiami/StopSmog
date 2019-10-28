import 'package:json_annotation/json_annotation.dart';

import 'Values.dart';

part 'ParamDetails.g.dart';

@JsonSerializable()
class ParamDetails {
  final String key;
  final List<Values> values;

  ParamDetails({this.key, this.values});
  factory ParamDetails.fromJson(Map<String, dynamic> json) => _$ParamDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ParamDetailsToJson(this);

}