// --------------
// Abstract repository for project-related data
// --------------
import 'package:dartz/dartz.dart';

import '../../Common/Error/error_handler.dart';
import '../Entities/project_entity.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<ProjectEntity>>> getAllProjects();
  Future<Either<Failure, ProjectEntity>> getProjectById(String projectId);
}