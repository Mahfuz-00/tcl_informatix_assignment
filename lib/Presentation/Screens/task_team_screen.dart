// ------------------------------------------------------------
// Tasks & Team Screen
//
// - Displays all tasks of a project grouped by status:
//     • Not Started
//     • In Progress
//     • Completed
// - Shows team members with expandable accordions
// - Integrates with ProjectDetailsBloc for live project data
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Common/Services/theme_service.dart';
import '../../Domain/Entities/task_entity.dart';
import '../Bloc/project_details_bloc.dart';
import '../Bloc/project_details_event.dart';
import '../Bloc/project_details_state.dart';
import '../Widgets/task_item.dart';
import '../Widgets/team_accordion.dart';

class TaskTeamScreen extends StatefulWidget {
  final String projectId;

  const TaskTeamScreen({required this.projectId, super.key});

  @override
  State<TaskTeamScreen> createState() => _TaskTeamScreenState();
}

class _TaskTeamScreenState extends State<TaskTeamScreen> {

  @override
  void initState() {
    super.initState();
    final projectId = widget.projectId;
    final bloc = context.read<ProjectDetailsBloc>();
    if (!(bloc.state is ProjectDetailsLoaded && (bloc.state as ProjectDetailsLoaded).project.projectId == projectId)) {
      bloc.add(LoadProjectDetails(projectId));
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tasks & Team'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () => context.read<ThemeService>().toggleTheme(),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
          builder: (context, state) {
            if (state is ProjectDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProjectDetailsError) {
              return Center(child: Text(state.message));
            }
            if (state is ProjectDetailsLoaded && state.project.projectId == widget.projectId) {
              final project = state.project;

              // Group tasks by status
              final Map<String, List<TaskEntity>> taskGroups = {};
              for (var task in project.tasks) {
                final status = task.progress == 100
                    ? 'Completed'
                    : task.progress > 0
                    ? 'In Progress'
                    : 'Not Started';
                taskGroups.putIfAbsent(status, () => []).add(task);
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------- Tasks Section ----------------
                    const Text(
                      'Tasks',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    ...taskGroups.entries.map(
                          (entry) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Task list
                          ...entry.value.map(
                                (task) => TaskItem(task: task, showDetails: true),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    // ---------------- Teams Section ----------------
                    const Text(
                      'Teams',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    if (project.teams.isEmpty)
                      Center(
                        child: Text(
                          'No teams assigned yet',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    else
                    const SizedBox(height: 16),
                    ...project.teams.map(
                          (team) => TeamAccordion(
                        team: team,
                      ),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text('Loading project details...'));
          },
        ),
      ),
    );
  }
}
