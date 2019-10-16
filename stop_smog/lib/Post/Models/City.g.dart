// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'City.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
      id: json['id'] as int,
      name: json['name'] as String,
      commune: json['commune'] == null
          ? null
          : Commune.fromJson(json['commune'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'commune': instance.commune
    };
