// --------------
// Usecase: Get list of all projects
// --------------
import 'package:dartz/dartz.dart';

import '../../Common/Error/error_handler.dart';
import '../../Domain/Entities/project_entity.dart';
import '../../Domain/Repositories/project_repository.dart';

class GetProjects {
  final ProjectRepository repository;

  GetProjects(this.repository);

  Future<Either<Failure, List<ProjectEntity>>> call() async {
    return await repository.getAllProjects();
  }
}