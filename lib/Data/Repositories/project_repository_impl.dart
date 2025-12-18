// --------------
// ProjectRepository implementation – reuses mapping from CompanyRepo
// --------------
import 'package:dartz/dartz.dart';

import '../../Common/Error/error_handler.dart';
import '../../Domain/Entities/project_entity.dart';
import '../../Domain/Repositories/project_repository.dart';
import '../Sources/Local/local_data_source.dart';
import 'company_repository_impl.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final LocalDataSource localDataSource;
  final CompanyRepositoryImpl _companyRepoImpl;

  ProjectRepositoryImpl({required this.localDataSource})
      : _companyRepoImpl = CompanyRepositoryImpl(localDataSource: localDataSource);

  @override
  Future<Either<Failure, List<ProjectEntity>>> getAllProjects() async {
    try {
      final models = await localDataSource.getAllProjects();
      final entities = models.map(_companyRepoImpl.mapProjectModelToEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ParsingFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> getProjectById(String projectId) async {
    try {
      final model = await localDataSource.getProjectById(projectId);
      return Right(_companyRepoImpl.mapProjectModelToEntity(model));
    } catch (e) {
      return Left(ParsingFailure(e.toString()));
    }
  }
}