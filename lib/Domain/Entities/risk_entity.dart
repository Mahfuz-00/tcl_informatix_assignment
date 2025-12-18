// --------------
// Risk entity
// --------------

class RiskEntity {
  final String riskId;
  final String description;
  final String severity;
  final String mitigation;

  RiskEntity({
    required this.riskId,
    required this.description,
    required this.severity,
    required this.mitigation,
  });
}