// --------------
// Abstract repository for company-level information
// --------------
import 'package:dartz/dartz.dart';

import '../../Common/Error/error_handler.dart';
import '../Entities/company_entity.dart';

abstract class CompanyRepository {
  Future<Either<Failure, CompanyEntity>> getCompanyInfo();
}