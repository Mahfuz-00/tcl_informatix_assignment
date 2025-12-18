// --------------
// Team and member models
// --------------
import 'package:json_annotation/json_annotation.dart';

part 'team_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Team {
  final String teamId;
  final String name;
  final List<Member> members;

  Team({
    required this.teamId,
    required this.name,
    required this.members,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

@JsonSerializable()
class Member {
  final String name;
  final String role;

  Member({
    required this.name,
    required this.role,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}