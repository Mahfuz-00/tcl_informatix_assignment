// --------------
// CompanyRepository implementation with inline mapping
// --------------
import 'package:dartz/dartz.dart';

import '../../Common/Error/error_handler.dart';
import '../../Domain/Entities/budget_entity.dart';
import '../../Domain/Entities/company_entity.dart';
import '../../Domain/Entities/manager_entity.dart';
import '../../Domain/Entities/payment_entity.dart';
import '../../Domain/Entities/project_entity.dart';
import '../../Domain/Entities/risk_entity.dart';
import '../../Domain/Entities/task_entity.dart';
import '../../Domain/Entities/team_entity.dart';
import '../../Domain/Entities/timeline_entity.dart';
import '../../Domain/Repositories/company_repository.dart';
import '../Sources/Local/local_data_source.dart';
import '../Models/company_model.dart';
import '../Models/project_model.dart';
import '../Models/budget_model.dart';
import '../Models/manager_model.dart';
import '../Models/payment_model.dart';
import '../Models/risk_model.dart';
import '../Models/task_model.dart';
import '../Models/team_model.dart';
import '../Models/timeline_model.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final LocalDataSource localDataSource;

  CompanyRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, CompanyEntity>> getCompanyInfo() async {
    try {
      final model = await localDataSource.getCompanyInfo();
      return Right(_mapToEntity(model));
    } catch (e) {
      return Left(ParsingFailure(e.toString()));
    }
  }

  CompanyEntity _mapToEntity(CompanyModel model) {
    return CompanyEntity(
      companyId: model.companyId,
      name: model.name,
      currency: model.currency,
      headOffice: HeadOfficeEntity(
        address: model.headOffice.address,
        contact: ContactEntity(
          phone: model.headOffice.contact.phone,
          email: model.headOffice.contact.email,
        ),
      ),
      projects: model.projects.map(mapProjectModelToEntity).toList(),
    );
  }

  ProjectEntity mapProjectModelToEntity(ProjectModel model) {
    return ProjectEntity(
      projectId: model.projectId,
      name: model.name,
      status: model.status,
      timeline: TimelineEntity(
        startDate: model.timeline.startDate,
        endDate: model.timeline.endDate,
        milestones: model.timeline.milestones
            .map((m) => MilestoneEntity(milestoneId: m.milestoneId, title: m.title, status: m.status))
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
        members: t.members.map((m) => MemberEntity(name: m.name, role: m.role)).toList(),
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
              ?.map((sc) => SubCategoryEntity(name: sc.name, allocated: sc.allocated, spent: sc.spent))
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
            .map((st) => SubTaskEntity(subTaskId: st.subTaskId, title: st.title, status: st.status))
            .toList(),
        activityLogs: t.activityLogs
            .map((log) => ActivityLogEntity(date: log.date, updatedBy: log.updatedBy, remark: log.remark))
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
            .map((i) => InvoiceEntity(invoiceId: i.invoiceId, vendor: i.vendor, amount: i.amount))
            .toList(),
        approvalFlow: ApprovalFlowEntity(
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