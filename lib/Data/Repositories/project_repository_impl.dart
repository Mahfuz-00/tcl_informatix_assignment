// ------------------------------------------------------------
// ProjectRepository Implementation
//
// - Implements ProjectRepository using LocalDataSource
// - Maps ProjectModel -> ProjectEntity
// - Provides methods:
//   • getAllProjects: returns List<ProjectEntity>
//   • getProjectById: returns ProjectEntity for given ID
// - Handles parsing failures using Either<Failure, ...>
// - Strict: Only project-level data; no company info included
// ------------------------------------------------------------

import 'package:dartz/dartz.dart';

import '../../Common/Error/error_handler.dart';
import '../../Domain/Entities/budget_entity.dart';
import '../../Domain/Entities/manager_entity.dart';
import '../../Domain/Entities/payment_entity.dart';
import '../../Domain/Entities/project_entity.dart';
import '../../Domain/Entities/risk_entity.dart';
import '../../Domain/Entities/task_entity.dart';
import '../../Domain/Entities/team_entity.dart';
import '../../Domain/Entities/timeline_entity.dart';
import '../../Domain/Repositories/project_repository.dart';
import '../Sources/Local/local_data_source.dart';
import '../Models/project_model.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final LocalDataSource localDataSource;

  ProjectRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ProjectEntity>>> getAllProjects() async {
    try {
      final models = await localDataSource.getAllProjects();
      final entities = models.map(mapProjectModelToEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ParsingFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> getProjectById(String projectId) async {
    try {
      final model = await localDataSource.getProjectById(projectId);
      return Right(mapProjectModelToEntity(model));
    } catch (e) {
      return Left(ParsingFailure(e.toString()));
    }
  }

  // -----------------------------
  // Mapping: ProjectModel -> ProjectEntity
  // -----------------------------
  ProjectEntity mapProjectModelToEntity(ProjectModel model) {
    return ProjectEntity(
      projectId: model.projectId,
      name: model.name,
      status: model.status,
      timeline: TimelineEntity(
        startDate: model.timeline.startDate,
        endDate: model.timeline.endDate,
        milestones: model.timeline.milestones
            .map((m) => MilestoneEntity(
          milestoneId: m.milestoneId,
          title: m.title,
          status: m.status,
        ))
            .toList(),
      ),
      manager: ManagerEntity(
        employeeId: model.manager.employeeId,
        name: model.manager.name,
        designation: model.manager.designation,
        email: model.manager.email,
      ),
      teams: model.teams
          .map((t) => TeamEntity(
        teamId: t.teamId,
        name: t.name,
        members:
        t.members.map((m) => MemberEntity(name: m.name, role: m.role)).toList(),
      ))
          .toList(),
      budget: BudgetEntity(
        total: model.budget.total,
        spent: model.budget.spent,
        categories: model.budget.categories
            .map((c) => CategoryEntity(
          name: c.name,
          allocated: c.allocated,
          spent: c.spent,
          subCategories: c.subCategories
              ?.map((sc) => SubCategoryEntity(
            name: sc.name,
            allocated: sc.allocated,
            spent: sc.spent,
          ))
              .toList(),
        ))
            .toList(),
      ),
      tasks: model.tasks
          .map((t) => TaskEntity(
        taskId: t.taskId,
        title: t.title,
        assignedTeam: t.assignedTeam,
        priority: t.priority,
        progress: t.progress,
        subTasks: t.subTasks
            .map((st) => SubTaskEntity(
          subTaskId: st.subTaskId,
          title: st.title,
          status: st.status,
        ))
            .toList(),
        activityLogs: t.activityLogs
            .map((log) => ActivityLogEntity(
          date: log.date,
          updatedBy: log.updatedBy,
          remark: log.remark,
        ))
            .toList(),
      ))
          .toList(),
      payments: model.payments
          .map((p) => PaymentEntity(
        paymentId: p.paymentId,
        amount: p.amount,
        requestedBy: p.requestedBy,
        requestDate: p.requestDate,
        invoices: p.invoices
            .map((i) => InvoiceEntity(
          invoiceId: i.invoiceId,
          vendor: i.vendor,
          amount: i.amount,
        ))
            .toList(),
        approvalFlow: ApprovalEntity(
          approvedBy: p.approvalFlow.approvedBy,
          approvedDate: p.approvalFlow.approvedDate,
          status: p.approvalFlow.status,
        ),
      ))
          .toList(),
      risks: model.risks
          .map((r) => RiskEntity(
        riskId: r.riskId,
        description: r.description,
        severity: r.severity,
        mitigation: r.mitigation,
      ))
          .toList(),
    );
  }
}
