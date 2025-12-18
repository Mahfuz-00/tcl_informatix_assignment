// --------------
// Payments & Approvals Screen - Consistent design
// Clean list of payments with status badges, bottom navigation
// --------------
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Common/Services/theme_service.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/status_badge.dart';
import '../Bloc/project_details_bloc.dart';
import '../Bloc/project_details_state.dart';

class PaymentsApprovalsScreen extends StatelessWidget {
  final String projectId;

  const PaymentsApprovalsScreen({required this.projectId, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.tertiary,
        appBar: AppBar(
          title: const Text('Payments & Approvals'),
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
            if (state is ProjectDetailsLoaded && state.project.projectId == projectId) {
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