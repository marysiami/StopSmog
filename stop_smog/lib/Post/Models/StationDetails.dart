import 'package:json_annotation/json_annotation.dart';

import 'Param.dart';

part 'StationDetails.g.dart';

@JsonSerializable()
class StationDetails {
  final int id;
  final int stationId;
  final Param param;

  StationDetails({this.id, this.stationId, this.param});
  factory StationDetails.fromJson(Map<String, dynamic> json) => _$StationDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$StationDetailsToJson(this);

}