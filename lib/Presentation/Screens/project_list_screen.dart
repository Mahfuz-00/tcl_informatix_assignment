import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Common/Services/theme_service.dart';
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
        backgroundColor: colorScheme.tertiary,
        appBar: AppBar(
          title: const Text('Projects'),
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
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
      
              return Container(
                color: colorScheme.tertiary,
                child: ListView.builder(
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
                                _ActionTile(
                                  icon: Icons.info_outline,
                                  label: 'Details',
                                  color: colorScheme.primary,
                                  onTap: () {
                                    context.push(
                                      '/project/${project.projectId}',
                                    );
                                  },
                                ),
                                const SizedBox(width: 12),
                                _ActionTile(
                                  icon: Icons.task_alt,
                                  label: 'Tasks',
                                  color: Colors.orange,
                                  onTap: () {
                                    context.push(
                                      '/tasks/${project.projectId}',
                                    );
                                  },
                                ),
                                const SizedBox(width: 12),
                                _ActionTile(
                                  icon: Icons.payment,
                                  label: 'Payments',
                                  color: Colors.green,
                                  onTap: () {
                                    context.push(
                                      '/payments/${project.projectId}',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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

/// ----------------------------
/// Action Tile Widget
/// ----------------------------
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: color.withOpacity(0.08),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 26),
              const SizedBox(height: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
