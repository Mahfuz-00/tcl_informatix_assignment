// --------------
// Usecase: Get full details of one project
// --------------
import 'package:dartz/dartz.dart';

import '../../Common/Error/error_handler.dart';
import '../../Domain/Entities/project_entity.dart';
import '../../Domain/Repositories/project_repository.dart';

class GetProjectDetails {
  final ProjectRepository repository;

  GetProjectDetails(this.repository);

  Future<Either<Failure, ProjectEntity>> call(String projectId) async {
    return await repository.getProjectById(projectId);
  }
}