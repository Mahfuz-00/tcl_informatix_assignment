class TaskEntity {
  final String taskId;
  final String title;
  final String assignedTeam;
  final String priority;
  final int progress;
  final List<SubTaskEntity> subTasks;
  final List<ActivityLogEntity> activityLogs;

  TaskEntity({
    required this.taskId,
    required this.title,
    required this.assignedTeam,
    required this.priority,
    required this.progress,
    required this.subTasks,
    required this.activityLogs,
  });
}

class SubTaskEntity {
  final String subTaskId;
  final String title;
  final String status;

  SubTaskEntity({
    required this.subTaskId,
    required this.title,
    required this.status,
  });
}

class ActivityLogEntity {
  final String date;
  final String updatedBy;
  final String remark;

  ActivityLogEntity({
    required this.date,
    required this.updatedBy,
    required this.remark,
  });
}