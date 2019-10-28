// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParamDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParamDetails _$ParamDetailsFromJson(Map<String, dynamic> json) {
  return ParamDetails(
      key: json['key'] as String,
      values: (json['values'] as List)
          ?.map((e) =>
              e == null ? null : Values.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ParamDetailsToJson(ParamDetails instance) =>
    <String, dynamic>{'key': instance.key, 'values': instance.values};
