import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'status_badge.dart';
import '../../Domain/Entities/project_entity.dart';
import 'info_row.dart';

class ProjectCard extends StatelessWidget {
  final ProjectEntity project;

  const ProjectCard({required this.project, super.key});

  @override
  Widget build(BuildContext context) {

    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project name + status in column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: StatusBadge(
                    status: project.status,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Manager info
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueGrey[200],
                  child: Icon(Icons.person, color: Colors.blueGrey[700]),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.manager.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      project.manager.designation,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Timeline
            InfoRow(
              icon: Icons.date_range,
              text:
              'Timeline: ${project.timeline.startDate} – ${project.timeline.endDate}',
              ),
          ],
        ),
      ),
    );
  }
}
