// --------------
// Team entity
// --------------
class TeamEntity {
  final String teamId;
  final String name;
  final List<MemberEntity> members;

  TeamEntity({
    required this.teamId,
    required this.name,
    required this.members,
  });
}

// --------------
// Member entity
// --------------
class MemberEntity {
  final String name;
  final String role;

  MemberEntity({
    required this.name,
    required this.role,
  });
}