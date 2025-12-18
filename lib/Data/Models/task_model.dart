// --------------
// Task, Sub-Task, Activity model
// --------------
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  final String taskId;
  final String title;
  final String assignedTeam;
  final String priority;
  final int progress;
  final List<SubTask> subTasks;
  final List<ActivityLog> activityLogs;

  Task({
    required this.taskId,
    required this.title,
    required this.assignedTeam,
    required this.priority,
    required this.progress,
    required this.subTasks,
    required this.activityLogs,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable()
class SubTask {
  final String subTaskId;
  final String title;
  final String status;

  SubTask({
    required this.subTaskId,
    required this.title,
    required this.status,
  });

  factory SubTask.fromJson(Map<String, dynamic> json) => _$SubTaskFromJson(json);
  Map<String, dynamic> toJson() => _$SubTaskToJson(this);
}

@JsonSerializable()
class ActivityLog {
  final String date;
  final String updatedBy;
  final String remark;

  ActivityLog({
    required this.date,
    required this.updatedBy,
    required this.remark,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) => _$ActivityLogFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityLogToJson(this);
}