// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welfare_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WelfareProject _$WelfareProjectFromJson(Map<String, dynamic> json) =>
    _WelfareProject(
      id: json['id'] as String,
      sector: json['sector'] as String,
      title: json['title'] as String,
      district: json['district'] as String,
      target: (json['target'] as num).toInt(),
      raised: (json['raised'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$WelfareProjectToJson(_WelfareProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sector': instance.sector,
      'title': instance.title,
      'district': instance.district,
      'target': instance.target,
      'raised': instance.raised,
      'created_at': instance.createdAt.toIso8601String(),
    };
