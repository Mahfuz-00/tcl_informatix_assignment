// ------------------------------------------------------------
// Payments & Approvals Screen
//
// - Displays all payment requests for a specific project
// - Shows payment amount, requester, date, and approval status
// - Approved payments display approver and approval date
// - Uses ProjectDetailsBloc to fetch and display live project payment data
// - Integrates theme toggle and consistent app styling
// - Supports scrollable list and empty state message
// ------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Common/Services/theme_service.dart';
import '../Bloc/project_details_event.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/status_badge.dart';
import '../Bloc/project_details_bloc.dart';
import '../Bloc/project_details_state.dart';

class PaymentsApprovalsScreen extends StatefulWidget {
  final String projectId;

  const PaymentsApprovalsScreen({required this.projectId, super.key});

  @override
  State<PaymentsApprovalsScreen> createState() => _PaymentsApprovalsScreenState();
}

class _PaymentsApprovalsScreenState extends State<PaymentsApprovalsScreen> {
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
          title: const Text('Payments & Approvals'),
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
              final payments = state.project.payments;

              if (payments.isEmpty) {
                return const Center(
                  child: Text(
                    'No payment requests yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  return CustomCard(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Payment Request',
                                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              StatusBadge(status: payment.approvalFlow.status),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Amount: ${payment.amount} BDT',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text('Requested by: ${payment.requestedBy}'),
                          Text('Date: ${payment.requestDate}'),
                          if (payment.approvalFlow.status == 'Approved') ...[
                            const SizedBox(height: 8),
                            Text(
                              'Approved by: ${payment.approvalFlow.approvedBy}',
                              style: TextStyle(color: Colors.green[700]),
                            ),
                            Text('on ${payment.approvalFlow.approvedDate}'),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('No payment details found'));
          },
        ),
      ),
    );
  }
}