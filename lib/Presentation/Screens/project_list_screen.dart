// ------------------------------------------------------------
// Project List Screen
//
// - Lists all projects with key info:
//     • Name
//     • Manager
//     • Status badge
//     • Budget utilization bar
// - Provides quick action tiles for:
//     • Project Details
//     • Tasks
//     • Payments
// - Uses ProjectsBloc to fetch and react to project data
// - Includes bottom navigation bar consistent with the app
// ------------------------------------------------------------


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Common/Services/theme_service.dart';
import '../Widgets/action_tile.dart';
import '../Widgets/app_bottom_nav_bar.dart';
import '../Widgets/status_badge.dart';
import '../Bloc/project_bloc.dart';
import '../Bloc/project_event.dart';
import '../Bloc/project_state.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectsBloc>().add(LoadProjects());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Projects'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () => context.read<ThemeService>().toggleTheme(),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: BlocBuilder<ProjectsBloc, ProjectsState>(
          builder: (context, state) {
            if (state is ProjectsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProjectsError) {
              return Center(child: Text(state.message));
            }

            if (state is ProjectsLoaded) {
              if (state.projects.isEmpty) {
                return const Center(child: Text('No projects found'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.projects.length,
                itemBuilder: (context, index) {
                  final project = state.projects[index];
                  final utilization = project.budget.total > 0
                      ? project.budget.spent / project.budget.total
                      : 0.0;

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ---- Header ----
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  project.name,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              StatusBadge(status: project.status),
                            ],
                          ),

                          const SizedBox(height: 8),
                          Text(
                            'Manager: ${project.manager.name}',
                            style: theme.textTheme.bodyMedium,
                          ),

                          const SizedBox(height: 16),

                          // ---- Budget ----
                          LinearProgressIndicator(
                            value: utilization,
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(8),
                            backgroundColor: colorScheme.surfaceVariant,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              utilization > 0.9
                                  ? Colors.red
                                  : utilization > 0.7
                                  ? Colors.orange
                                  : colorScheme.primary,
                            ),
                          ),

                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${(utilization * 100).toStringAsFixed(0)}% budget used',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ---- Action Tiles ----
                          Row(
                            children: [
                              Expanded(
                                child: ActionTile(
                                  icon: Icons.info_outline,
                                  label: 'Details',
                                  color: colorScheme.primary,
                                  onTap: () {
                                    context.push('/project/${project.projectId}');
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ActionTile(
                                  icon: Icons.task_alt,
                                  label: 'Tasks',
                                  color: colorScheme.secondary,
                                  onTap: () {
                                    context.push('/tasks/${project.projectId}');
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ActionTile(
                                  icon: Icons.payment,
                                  label: 'Payments',
                                  color: colorScheme.tertiary,
                                  onTap: () {
                                    context.push('/payments/${project.projectId}');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: AppBottomNavBar(),
      ),
    );
  }
}