import 'package:json_annotation/json_annotation.dart';

import 'City.dart';
part 'Station.g.dart';
@JsonSerializable(explicitToJson: true)
class Station {
  final int id;
  final String stationName;
  final String gegrLat;
  final String gegrLon;
  final City city;
  final String addressStreet;

  Station({this.id, this.stationName, this.gegrLat, this.gegrLon,this.city,this.addressStreet});


  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);

  Map<String, dynamic> toJson() => _$StationToJson(this);
}