import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../Presentation/Screens/dashboard_screen.dart';
import '../../Presentation/Screens/project_list_screen.dart';
import '../../Presentation/Screens/project_details_screen.dart';
import '../../Presentation/Screens/task_team_screen.dart';
import '../../Presentation/Screens/payments_approvals_screen.dart';

// --------------
// Sets up app routing using GoRouter.
// Defines routes for the 5 screens, with params for details (e.g., projectId).
// Root is dashboard.
// --------------
final GoRouter appRouter = GoRouter(
routes: [
GoRoute(
path: '/',
builder: (context, state) => DashboardScreen(),
),
GoRoute(
path: '/projects',
builder: (context, state) => ProjectListScreen(),
),
GoRoute(
path: '/project/:projectId',
builder: (context, state) => ProjectDetailsScreen(
projectId: state.pathParameters['projectId']!,
),
),
GoRoute(
path: '/tasks/:projectId',
builder: (context, state) => TaskTeamScreen(
projectId: state.pathParameters['projectId']!,
),
),
GoRoute(
path: '/payments/:projectId',
builder: (context, state) => PaymentsApprovalsScreen(
projectId: state.pathParameters['projectId']!,
),
),
],
);