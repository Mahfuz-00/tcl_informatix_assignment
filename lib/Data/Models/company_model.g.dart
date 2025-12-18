// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
  companyId: json['companyId'] as String,
  name: json['name'] as String,
  currency: json['currency'] as String,
  headOffice: HeadOffice.fromJson(json['headOffice'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
      'name': instance.name,
      'currency': instance.currency,
      'headOffice': instance.headOffice.toJson(),
    };

HeadOffice _$HeadOfficeFromJson(Map<String, dynamic> json) => HeadOffice(
  address: json['address'] as String,
  contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HeadOfficeToJson(HeadOffice instance) =>
    <String, dynamic>{'address': instance.address, 'contact': instance.contact};

Contact _$ContactFromJson(Map<String, dynamic> json) =>
    Contact(phone: json['phone'] as String, email: json['email'] as String);

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
  'phone': instance.phone,
  'email': instance.email,
};
