// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Risk _$RiskFromJson(Map<String, dynamic> json) => Risk(
  riskId: json['riskId'] as String,
  description: json['description'] as String,
  severity: json['severity'] as String,
  mitigation: json['mitigation'] as String,
);

Map<String, dynamic> _$RiskToJson(Risk instance) => <String, dynamic>{
  'riskId': instance.riskId,
  'description': instance.description,
  'severity': instance.severity,
  'mitigation': instance.mitigation,
};
