import 'package:json_annotation/json_annotation.dart';

part 'Values.g.dart';

@JsonSerializable()
class Values {
  final String date;
  final double value;

  Values({this.date, this.value});
  factory Values.fromJson(Map<String, dynamic> json) => _$ValuesFromJson(json);
  Map<String, dynamic> toJson() => _$ValuesToJson(this);

}