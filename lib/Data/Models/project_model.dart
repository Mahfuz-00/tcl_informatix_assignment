// --------------
// Project model
// --------------
import 'package:json_annotation/json_annotation.dart';

import 'budget_model.dart';
import 'manager_model.dart';
import 'payment_model.dart';
import 'risk_model.dart';
import 'task_model.dart';
import 'team_model.dart';
import 'timeline_model.dart';

part 'project_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectModel {
  final String projectId;
  final String name;
  final String status;
  final Timeline timeline;
  final Manager manager;
  final List<Team> teams;
  final Budget budget;
  final List<Task> tasks;
  final List<Payment> payments;
  final List<Risk> risks;

  ProjectModel({
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

  factory ProjectModel.fromJson(Map<String, dynamic> json) => _$ProjectModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}