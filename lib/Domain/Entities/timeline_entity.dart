// --------------
// Timeline entity
// --------------

class TimelineEntity {
  final String startDate;
  final String endDate;
  final List<MilestoneEntity> milestones;

  TimelineEntity({
    required this.startDate,
    required this.endDate,
    required this.milestones,
  });
}


// --------------
// Milestone entity
// --------------
class MilestoneEntity {
  final String milestoneId;
  final String title;
  final String status;

  MilestoneEntity({
    required this.milestoneId,
    required this.title,
    required this.status,
  });
}