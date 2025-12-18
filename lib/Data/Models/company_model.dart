// --------------
// Company data transfer model (JSON → Dart)
// Mirrors CompanyEntity structure exactly
// --------------
import 'package:json_annotation/json_annotation.dart';

import 'project_model.dart';

part 'company_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyModel {
  final String companyId;
  final String name;
  final String currency;
  final HeadOffice headOffice;
  final List<ProjectModel> projects;

  CompanyModel({
    required this.companyId,
    required this.name,
    required this.currency,
    required this.headOffice,
    required this.projects,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => _$CompanyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}

@JsonSerializable()
class HeadOffice {
  final String address;
  final Contact contact;

  HeadOffice({required this.address, required this.contact});

  factory HeadOffice.fromJson(Map<String, dynamic> json) => _$HeadOfficeFromJson(json);
  Map<String, dynamic> toJson() => _$HeadOfficeToJson(this);
}

@JsonSerializable()
class Contact {
  final String phone;
  final String email;

  Contact({required this.phone, required this.email});

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}