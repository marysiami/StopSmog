import 'package:json_annotation/json_annotation.dart';
part 'Param.g.dart';

@JsonSerializable()
class Param {
  final int idParam;
  final String paramName;
  final String paramFormula;
  final String paramCode;

  Param({this.idParam, this.paramName, this.paramFormula,this.paramCode});
  factory Param.fromJson(Map<String, dynamic> json) => _$ParamFromJson(json);
  Map<String, dynamic> toJson() => _$ParamToJson(this);

}