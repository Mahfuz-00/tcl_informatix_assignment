// --------------
// Risk model
// --------------
import 'package:json_annotation/json_annotation.dart';

part 'risk_model.g.dart';

@JsonSerializable()
class Risk {
  final String riskId;
  final String description;
  final String severity;
  final String mitigation;

  Risk({
    required this.riskId,
    required this.description,
    required this.severity,
    required this.mitigation,
  });

  factory Risk.fromJson(Map<String, dynamic> json) => _$RiskFromJson(json);
  Map<String, dynamic> toJson() => _$RiskToJson(this);
}