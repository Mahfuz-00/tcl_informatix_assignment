// ------------------------------------------------------------
// CompanyRepository Implementation
//
// - Implements CompanyRepository using LocalDataSource (MockAPI Json)
// - Maps only CompanyModel -> CompanyEntity
// - Handles parsing failures with Either<Failure, CompanyEntity>
// - Returns Right(entity) on success, Left(Failure) on error
// ------------------------------------------------------------

import 'package:dartz/dartz.dart';

import '../../Common/Error/error_handler.dart';
import '../../Domain/Entities/company_entity.dart';
import '../../Domain/Repositories/company_repository.dart';
import '../Sources/Local/local_data_source.dart';
import '../Models/company_model.dart';

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
    );
  }
}
