// --------------
// Company entity
// --------------

class CompanyEntity {
  final String companyId;
  final String name;
  final String currency;
  final HeadOfficeEntity headOffice;

  CompanyEntity({
    required this.companyId,
    required this.name,
    required this.currency,
    required this.headOffice,
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