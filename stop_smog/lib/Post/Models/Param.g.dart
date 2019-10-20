// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Param _$ParamFromJson(Map<String, dynamic> json) {
  return Param(
      idParam: json['idParam'] as int,
      paramName: json['paramName'] as String,
      paramFormula: json['paramFormula'] as String,
      paramCode: json['paramCode'] as String);
}

Map<String, dynamic> _$ParamToJson(Param instance) => <String, dynamic>{
      'idParam': instance.idParam,
      'paramName': instance.paramName,
      'paramFormula': instance.paramFormula,
      'paramCode': instance.paramCode
    };
