// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timeline _$TimelineFromJson(Map<String, dynamic> json) => Timeline(
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  milestones: (json['milestones'] as List<dynamic>)
      .map((e) => Milestone.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TimelineToJson(Timeline instance) => <String, dynamic>{
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'milestones': instance.milestones.map((e) => e.toJson()).toList(),
};
