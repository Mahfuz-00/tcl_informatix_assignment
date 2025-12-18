// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
  teamId: json['teamId'] as String,
  name: json['name'] as String,
  members: (json['members'] as List<dynamic>)
      .map((e) => Member.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
  'teamId': instance.teamId,
  'name': instance.name,
  'members': instance.members.map((e) => e.toJson()).toList(),
};

Member _$MemberFromJson(Map<String, dynamic> json) =>
    Member(name: json['name'] as String, role: json['role'] as String);

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
  'name': instance.name,
  'role': instance.role,
};
