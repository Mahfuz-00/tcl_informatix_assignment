// --------------
// Remote data source interface – empty for now
// When live backend exists(if ever), i will implement the same methods using http
// --------------

import '../../Models/company_model.dart';
import '../../Models/project_model.dart';

abstract class RemoteDataSource {
  Future<CompanyModel> getCompanyInfo();
  Future<List<ProjectModel>> getAllProjects();
  Future<ProjectModel> getProjectById(String projectId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  // TODO: Implement with Dio or http when backend is ready
  @override
  Future<CompanyModel> getCompanyInfo() {
    throw UnimplementedError('Remote not implemented yet');
  }

  @override
  Future<List<ProjectModel>> getAllProjects() {
    throw UnimplementedError('Remote not implemented yet');
  }

  @override
  Future<ProjectModel> getProjectById(String projectId) {
    throw UnimplementedError('Remote not implemented yet');
  }
}