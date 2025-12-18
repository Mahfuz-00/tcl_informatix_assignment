// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Manager _$ManagerFromJson(Map<String, dynamic> json) => Manager(
  employeeId: json['employeeId'] as String,
  name: json['name'] as String,
  designation: json['designation'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$ManagerToJson(Manager instance) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'name': instance.name,
  'designation': instance.designation,
  'email': instance.email,
};
