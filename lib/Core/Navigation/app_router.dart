// ------------------------------------------------------------
// App Routing (GoRouter)
//
// - Sets up all app navigation routes using GoRouter
// - Defines routes for the 5 screens, with params for details (e.g., projectId).
// - Root route: DashboardScreen
// - Other routes: ProjectListScreen, ProjectDetailsScreen, TaskTeamScreen, PaymentsApprovalsScreen
// - Dynamic parameters handled for projectId
// ------------------------------------------------------------


import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../Presentation/Screens/dashboard_screen.dart';
import '../../Presentation/Screens/project_list_screen.dart';
import '../../Presentation/Screens/project_details_screen.dart';
import '../../Presentation/Screens/task_team_screen.dart';
import '../../Presentation/Screens/payments_approvals_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => DashboardScreen()),
    GoRoute(
      path: '/projects',
      builder: (context, state) => ProjectListScreen(),
    ),
    GoRoute(
      path: '/project/:projectId',
      builder: (context, state) =>
          ProjectDetailsScreen(projectId: state.pathParameters['projectId']!),
    ),
    GoRoute(
      path: '/tasks/:projectId',
      builder: (context, state) =>
          TaskTeamScreen(projectId: state.pathParameters['projectId']!),
    ),
    GoRoute(
      path: '/payments/:projectId',
      builder: (context, state) => PaymentsApprovalsScreen(
        projectId: state.pathParameters['projectId']!,
      ),
    ),
  ],
);
