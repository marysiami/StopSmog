// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Commune.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commune _$CommuneFromJson(Map<String, dynamic> json) {
  return Commune(
      communeName: json['communeName'] as String,
      districtName: json['districtName'] as String,
      provinceName: json['provinceName'] as String);
}

Map<String, dynamic> _$CommuneToJson(Commune instance) => <String, dynamic>{
      'communeName': instance.communeName,
      'districtName': instance.districtName,
      'provinceName': instance.provinceName
    };
