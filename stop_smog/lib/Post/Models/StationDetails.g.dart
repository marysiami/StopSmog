// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StationDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationDetails _$StationDetailsFromJson(Map<String, dynamic> json) {
  return StationDetails(
      id: json['id'] as int,
      stationId: json['stationId'] as int,
      param: json['param'] == null
          ? null
          : Param.fromJson(json['param'] as Map<String, dynamic>));
}

Map<String, dynamic> _$StationDetailsToJson(StationDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stationId': instance.stationId,
      'param': instance.param
    };
