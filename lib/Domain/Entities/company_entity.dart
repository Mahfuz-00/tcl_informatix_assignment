// --------------
// Domain entities – pure Dart classes, no JSON annotations
// Mirror the structure present in the provided JSON only
// --------------

import 'project_entity.dart';

class CompanyEntity {
  final String companyId;
  final String name;
  final String currency;
  final HeadOfficeEntity headOffice;
  final List<ProjectEntity> projects;

  CompanyEntity({
    required this.companyId,
    required this.name,
    required this.currency,
    required this.headOffice,
    required this.projects,
  });
}

class HeadOfficeEntity {
  final String address;
  final ContactEntity contact;

  HeadOfficeEntity({
    required this.address,
    required this.contact,
  });
}

class ContactEntity {
  final String phone;
  final String email;

  ContactEntity({
    required this.phone,
    required this.email,
  });
}