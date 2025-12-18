// --------------
// Project Manager model
// --------------
import 'package:json_annotation/json_annotation.dart';

part 'manager_model.g.dart';

@JsonSerializable()
class Manager {
  final String employeeId;
  final String name;
  final String designation;
  final String email;

  Manager({
    required this.employeeId,
    required this.name,
    required this.designation,
    required this.email,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => _$ManagerFromJson(json);
  Map<String, dynamic> toJson() => _$ManagerToJson(this);
}