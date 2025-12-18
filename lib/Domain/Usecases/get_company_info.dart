// --------------
// Usecase: Get basic company information
// --------------
import 'package:dartz/dartz.dart';

import '../../Common/Error/error_handler.dart';
import '../../Domain/Entities/company_entity.dart';
import '../../Domain/Repositories/company_repository.dart';

class GetCompanyInfo {
  final CompanyRepository repository;

  GetCompanyInfo(this.repository);

  Future<Either<Failure, CompanyEntity>> call() async {
    return await repository.getCompanyInfo();
  }
}