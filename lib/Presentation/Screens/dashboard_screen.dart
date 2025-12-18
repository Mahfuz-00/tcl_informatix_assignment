// ------------------------------------------------------------
// Dashboard Screen
//
// - Main app dashboard with key metrics and interactive visualizations
// - Dynamic AppBar showing company name from CompanyBloc
// - Total Projects card with tappable segmented bar for project status counts
// - Budget allocation pie chart by category, interactive with touch feedback
// - Quick summary tiles for Pending Approvals and Active Tasks
// - Uses CompanyBloc and ProjectsBloc for live data
// - Bottom navigation bar consistent across app
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';

import '../../Common/Services/theme_service.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/app_bottom_nav_bar.dart';
import '../Widgets/custom_button.dart';
import '../Bloc/company_bloc.dart';
import '../Bloc/company_event.dart';
import '../Bloc/company_state.dart';
import '../Bloc/project_bloc.dart';
import '../Bloc/project_event.dart';
import '../Bloc/project_state.dart';
import '../Widgets/summary_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int? _touchedBarIndex;
  int? _touchedPieIndex;

  @override
  void initState() {
    super.initState();
    context.read<CompanyBloc>().add(LoadCompanyInfo());
    context.read<ProjectsBloc>().add(LoadProjects());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Scaffold(
        // Dynamic AppBar with company name from BLoC
        appBar: AppBar(
          title: BlocBuilder<CompanyBloc, CompanyState>(
            builder: (context, state) {
              if (state is CompanyLoaded) {
                return Text(state.company.name);
              }
              return const Text('Loading...');
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () => context.read<ThemeService>().toggleTheme(),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: BlocBuilder<CompanyBloc, CompanyState>(
          builder: (context, companyState) {
            if (companyState is! CompanyLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
      
            return BlocBuilder<ProjectsBloc, ProjectsState>(
              builder: (context, projectsState) {
                if (projectsState is! ProjectsLoaded) {
                  return const Center(child: CircularProgressIndicator());
                }
      
                final projects = projectsState.projects;
                final totalProjects = projects.length;
                final totalBudget = projects.fold(0, (sum, p) => sum + p.budget.total);
                final totalSpent = projects.fold(0, (sum, p) => sum + p.budget.spent);
                final pendingApprovals = projects.fold(0, (sum, p) => sum + p.payments.where((pay) => pay.approvalFlow.status != 'Approved').length);
      
                // Status counts for segmented bar
                final statusCounts = <String, int>{};
                for (var p in projects) {
                  statusCounts[p.status] = (statusCounts[p.status] ?? 0) + 1;
                }
                final statusList = ['Completed', 'In Progress', 'Planning'];
                final statusColors = {
                  'Completed': Colors.green,
                  'In Progress': Colors.orange,
                  'Planning': Colors.grey.shade600,
                };
      
                // Budget categories for pie chart
                final categoryMap = <String, int>{};
                for (var p in projects) {
                  for (var cat in p.budget.categories) {
                    categoryMap[cat.name] = (categoryMap[cat.name] ?? 0) + cat.allocated;
                  }
                }
      
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Total Projects Card - Tappable
                      InkWell(
                        onTap: () => context.push('/projects'),
                        borderRadius: BorderRadius.circular(16),
                        child: CustomCard(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.work, size: 32, color: colorScheme.primary),
                                    const SizedBox(width: 12),
                                    Text('Total Projects', style: theme.textTheme.titleLarge),
                                    const Spacer(),
                                    Text(
                                      '$totalProjects',
                                      style: theme.textTheme.headlineMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                // Segmented Progress Bar
                                GestureDetector(
                                  onTapUp: (details) {
                                    final renderBox = context.findRenderObject() as RenderBox;
                                    final width = renderBox.size.width - 40;
                                    final tapX = details.localPosition.dx;
                                    double cumulative = 0;
                                    int touched = -1;
                                    for (int i = 0; i < statusList.length; i++) {
                                      final count = statusCounts[statusList[i]] ?? 0;
                                      final segmentWidth = totalProjects > 0 ? (count / totalProjects) * width : 0;
                                      if (tapX < cumulative + segmentWidth) {
                                        touched = i;
                                        break;
                                      }
                                      cumulative += segmentWidth;
                                    }
                                    setState(() => _touchedBarIndex = touched);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: colorScheme.surfaceVariant,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      Row(
                                        children: statusList.asMap().entries.map((entry) {
                                          final idx = entry.key;
                                          final status = entry.value;
                                          final count = statusCounts[status] ?? 0;
                                          final fraction = totalProjects > 0 ? count / totalProjects : 0.0;
                                          final isTouched = idx == _touchedBarIndex;
                                          return Expanded(
                                            flex: (fraction * 100).round(),
                                            child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: statusColors[status]!.withOpacity(isTouched ? 0.8 : 1.0),
                                                borderRadius: idx == 0
                                                    ? const BorderRadius.horizontal(left: Radius.circular(20))
                                                    : idx == statusList.length - 1
                                                    ? const BorderRadius.horizontal(right: Radius.circular(20))
                                                    : null,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '$count',
                                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 24,
                                  children: statusList.map((status) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(width: 16, height: 16, color: statusColors[status]),
                                        const SizedBox(width: 8),
                                        Text(status),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                if (_touchedBarIndex != null && _touchedBarIndex != -1) ...[
                                  const SizedBox(height: 12),
                                  Text(
                                    '${statusList[_touchedBarIndex!]}: ${statusCounts[statusList[_touchedBarIndex!]]} project${(statusCounts[statusList[_touchedBarIndex!]] ?? 0) > 1 ? 's' : ''}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Budget Pie Chart Card - Tappable
                      InkWell(
                        onTap: () => context.push('/projects'),
                        borderRadius: BorderRadius.circular(16),
                        child: CustomCard(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Budget Allocation by Category', style: theme.textTheme.titleLarge),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 240,
                                  child: PieChart(
                                    PieChartData(
                                      pieTouchData: PieTouchData(
                                        touchCallback: (event, response) {
                                          setState(() {
                                            _touchedPieIndex = response?.touchedSection?.touchedSectionIndex ?? -1;
                                          });
                                        },
                                      ),
                                      sections: categoryMap.entries.toList().asMap().entries.map((entry) {
                                        final idx = entry.key;
                                        final cat = entry.value;
                                        final isTouched = idx == _touchedPieIndex;
                                        return PieChartSectionData(
                                          value: cat.value.toDouble(),
                                          color: Colors.primaries[idx % Colors.primaries.length],
                                          title: '${(cat.value / totalBudget * 100).toStringAsFixed(0)}%',
                                          radius: isTouched ? 70 : 60,
                                          titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        );
                                      }).toList(),
                                      centerSpaceRadius: 40,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 8,
                                  children: categoryMap.entries.map((cat) {
                                    final colorIndex = categoryMap.keys.toList().indexOf(cat.key);
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 16,
                                          height: 16,
                                          color: Colors.primaries[colorIndex % Colors.primaries.length],
                                        ),
                                        const SizedBox(width: 8),
                                        Text('${cat.key}: ${cat.value}'),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Quick Summary
                      Text('Quick Summary', style: theme.textTheme.titleLarge),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => context.push('/approvals'),
                              child: SummaryTile(title: 'Pending Approvals', value: pendingApprovals.toString(), icon: Icons.pending_actions, color: Colors.red),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InkWell(
                              onTap: () => context.push('/tasks'),
                              child: SummaryTile(title: 'Active Tasks', value: projects.fold(0, (sum, p) => sum + p.tasks.length).toString(), icon: Icons.task, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: AppBottomNavBar(),
      ),
    );
  }
}
