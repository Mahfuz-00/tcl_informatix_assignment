import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tcl_informatix_assignment/Presentation/Widgets/action_tile.dart';

import '../../Common/Services/theme_service.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/status_badge.dart';
import '../Bloc/project_details_bloc.dart';
import '../Bloc/project_details_event.dart';
import '../Bloc/project_details_state.dart';
import '../Widgets/project_card.dart';
import '../Widgets/budget_breakdown.dart';
import '../Widgets/info_row.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final String projectId;

  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectDetailsBloc>().add(LoadProjectDetails(widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.tertiary,
        appBar: AppBar(
          title: const Text('Project Details'),
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
        body: BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
          builder: (context, state) {
            if (state is ProjectDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProjectDetailsError) {
              return Center(child: Text(state.message));
            }

            if (state is ProjectDetailsLoaded) {
              final project = state.project;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------- Project Summary ----------------
                    ProjectCard(project: project),

                    const SizedBox(height: 24),

                    // ---------------- Milestones ----------------
                    Text(
                      'Milestones',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ...project.timeline.milestones.map((m) => CustomCard(
                      child: ListTile(
                        leading: Icon(
                          m.status == 'Completed'
                              ? Icons.check_circle
                              : m.status == 'In Progress'
                              ? Icons.timelapse
                              : Icons.pending,
                          color: m.status == 'Completed'
                              ? Colors.green
                              : m.status == 'In Progress'
                              ? Colors.orange
                              : Colors.grey,
                        ),
                        title: Text(m.title),
                        trailing: Text(
                          m.status,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),

                    const SizedBox(height: 24),

                    // ---------------- Risks ----------------
                    Text(
                      'Risks',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ...project.risks.map((risk) => CustomCard(
                      child: ListTile(
                        title: Text(risk.description),
                        subtitle: Text('Mitigation: ${risk.mitigation}'),
                        trailing: Text(
                          risk.severity,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: risk.severity == 'High'
                                ? Colors.red
                                : risk.severity == 'Medium'
                                ? Colors.orange
                                : Colors.green,
                          ),
                        ),
                      ),
                    )),

                    const SizedBox(height: 24),

                    // ---------------- Tasks & Team Button ----------------
                    Row(
                      children: [
                        Expanded(
                          child: ActionTile(
                            label: 'Tasks & Team',
                            icon: Icons.task_alt,
                            color: Colors.orange,
                            onTap: () => context.push('/tasks/${project.projectId}'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ---------------- Budget Section ----------------
                    Text(
                      'Budget Breakdown',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    BudgetBreakdown(categories: project.budget.categories),

                    const SizedBox(height: 24),

                    // ---------------- Primary Actions ----------------
                    Row(
                      children: [
                        Expanded(
                          child: ActionTile(
                            label: 'Payments & Approvals',
                            icon: Icons.payment,
                            color: Colors.green,
                            onTap: () => context.push('/payments/${project.projectId}'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
