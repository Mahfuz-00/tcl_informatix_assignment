// --------------
// Milestone model
// --------------

import 'package:json_annotation/json_annotation.dart';

part 'milestone_model.g.dart';

@JsonSerializable()
class Milestone {
  final String milestoneId;
  final String title;
  final String status;

  Milestone({
    required this.milestoneId,
    required this.title,
    required this.status,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) => _$MilestoneFromJson(json);
  Map<String, dynamic> toJson() => _$MilestoneToJson(this);
}
