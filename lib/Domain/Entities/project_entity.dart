import 'budget_entity.dart';
import 'manager_entity.dart';
import 'payment_entity.dart';
import 'risk_entity.dart';
import 'task_entity.dart';
import 'team_entity.dart';
import 'timeline_entity.dart';

class ProjectEntity {
  final String projectId;
  final String name;
  final String status;
  final TimelineEntity timeline;
  final ManagerEntity manager;
  final List<TeamEntity> teams;
  final BudgetEntity budget;
  final List<TaskEntity> tasks;
  final List<PaymentEntity> payments;
  final List<RiskEntity> risks;

  ProjectEntity({
    required this.projectId,
    required this.name,
    required this.status,
    required this.timeline,
    required this.manager,
    required this.teams,
    required this.budget,
    required this.tasks,
    required this.payments,
    required this.risks,
  });
}