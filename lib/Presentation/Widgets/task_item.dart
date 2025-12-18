import 'package:flutter/material.dart';
import 'custom_button.dart';
import '../../Domain/Entities/task_entity.dart';

// --------------
// Sleek Task Item with Subtasks, Activity Logs & Inline Status
// --------------
class TaskItem extends StatelessWidget {
  final TaskEntity task;
  final bool showDetails;

  const TaskItem({required this.task, this.showDetails = false, super.key});

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  Color getProgressColor(int progress) {
    if (progress == 100) return Colors.green;
    if (progress >= 50) return Colors.orange;
    return Colors.red;
  }

  String getStatus(int progress) {
    if (progress == 100) return 'Completed';
    if (progress > 0) return 'In Progress';
    return 'Not Started';
  }

  Color getStatusColor(int progress) {
    if (progress == 100) return Colors.green;
    if (progress > 0) return Colors.orange;
    return Colors.grey;
  }

  Widget _buildSubTasks() {
    if (task.subTasks.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text('Subtasks', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 6),
        ...task.subTasks.map(
              (sub) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Icon(
                  sub.status == 'Completed'
                      ? Icons.check_circle
                      : sub.status == 'In Progress'
                      ? Icons.timelapse
                      : Icons.pending,
                  color: sub.status == 'Completed'
                      ? Colors.green
                      : sub.status == 'In Progress'
                      ? Colors.orange
                      : Colors.grey,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(sub.title, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityLogs() {
    if (task.activityLogs.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text('Activity Logs', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 6),
        ...task.activityLogs.map(
              (log) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              '${log.date} - ${log.updatedBy}: ${log.remark}',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final status = getStatus(task.progress);
    final statusColor = getStatusColor(task.progress);

    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task title
            Text(
              task.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),

            // Assigned, Priority & Status badges
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Assigned: ${task.assignedTeam}',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: getPriorityColor(task.priority).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        task.priority,
                        style: TextStyle(
                          color: getPriorityColor(task.priority),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Progress bar
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: task.progress / 100,
                      minHeight: 6,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation(getProgressColor(task.progress)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text('${task.progress}%', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              ],
            ),

            // Subtasks
            _buildSubTasks(),

            // Activity logs
            _buildActivityLogs(),
          ],
        ),
      ),
    );
  }
}
