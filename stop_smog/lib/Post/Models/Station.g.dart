// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) {
  return Station(
      id: json['id'] as int,
      stationName: json['stationName'] as String,
      gegrLat: json['gegrLat'] as String,
      gegrLon: json['gegrLon'] as String,
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      addressStreet: json['addressStreet'] as String);
}

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'id': instance.id,
      'stationName': instance.stationName,
      'gegrLat': instance.gegrLat,
      'gegrLon': instance.gegrLon,
      'city': instance.city?.toJson(),
      'addressStreet': instance.addressStreet
    };
