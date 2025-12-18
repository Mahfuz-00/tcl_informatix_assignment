// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Milestone _$MilestoneFromJson(Map<String, dynamic> json) => Milestone(
  milestoneId: json['milestoneId'] as String,
  title: json['title'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$MilestoneToJson(Milestone instance) => <String, dynamic>{
  'milestoneId': instance.milestoneId,
  'title': instance.title,
  'status': instance.status,
};
