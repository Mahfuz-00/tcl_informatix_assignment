// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) => ProjectModel(
  projectId: json['projectId'] as String,
  name: json['name'] as String,
  status: json['status'] as String,
  timeline: Timeline.fromJson(json['timeline'] as Map<String, dynamic>),
  manager: Manager.fromJson(json['manager'] as Map<String, dynamic>),
  teams: (json['teams'] as List<dynamic>)
      .map((e) => Team.fromJson(e as Map<String, dynamic>))
      .toList(),
  budget: Budget.fromJson(json['budget'] as Map<String, dynamic>),
  tasks: (json['tasks'] as List<dynamic>)
      .map((e) => Task.fromJson(e as Map<String, dynamic>))
      .toList(),
  payments: (json['payments'] as List<dynamic>)
      .map((e) => Payment.fromJson(e as Map<String, dynamic>))
      .toList(),
  risks: (json['risks'] as List<dynamic>)
      .map((e) => Risk.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'name': instance.name,
      'status': instance.status,
      'timeline': instance.timeline.toJson(),
      'manager': instance.manager.toJson(),
      'teams': instance.teams.map((e) => e.toJson()).toList(),
      'budget': instance.budget.toJson(),
      'tasks': instance.tasks.map((e) => e.toJson()).toList(),
      'payments': instance.payments.map((e) => e.toJson()).toList(),
      'risks': instance.risks.map((e) => e.toJson()).toList(),
    };
