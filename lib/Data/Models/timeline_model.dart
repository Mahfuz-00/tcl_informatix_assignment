import 'package:json_annotation/json_annotation.dart';
import 'milestone_model.dart';

part 'timeline_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Timeline {
  final String startDate;
  final String endDate;
  final List<Milestone> milestones;

  Timeline({
    required this.startDate,
    required this.endDate,
    required this.milestones,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) => _$TimelineFromJson(json);
  Map<String, dynamic> toJson() => _$TimelineToJson(this);
}
