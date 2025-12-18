// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  taskId: json['taskId'] as String,
  title: json['title'] as String,
  assignedTeam: json['assignedTeam'] as String,
  priority: json['priority'] as String,
  progress: (json['progress'] as num).toInt(),
  subTasks: (json['subTasks'] as List<dynamic>)
      .map((e) => SubTask.fromJson(e as Map<String, dynamic>))
      .toList(),
  activityLogs: (json['activityLogs'] as List<dynamic>)
      .map((e) => ActivityLog.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'taskId': instance.taskId,
  'title': instance.title,
  'assignedTeam': instance.assignedTeam,
  'priority': instance.priority,
  'progress': instance.progress,
  'subTasks': instance.subTasks.map((e) => e.toJson()).toList(),
  'activityLogs': instance.activityLogs.map((e) => e.toJson()).toList(),
};

SubTask _$SubTaskFromJson(Map<String, dynamic> json) => SubTask(
  subTaskId: json['subTaskId'] as String,
  title: json['title'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$SubTaskToJson(SubTask instance) => <String, dynamic>{
  'subTaskId': instance.subTaskId,
  'title': instance.title,
  'status': instance.status,
};

ActivityLog _$ActivityLogFromJson(Map<String, dynamic> json) => ActivityLog(
  date: json['date'] as String,
  updatedBy: json['updatedBy'] as String,
  remark: json['remark'] as String,
);

Map<String, dynamic> _$ActivityLogToJson(ActivityLog instance) =>
    <String, dynamic>{
      'date': instance.date,
      'updatedBy': instance.updatedBy,
      'remark': instance.remark,
    };
