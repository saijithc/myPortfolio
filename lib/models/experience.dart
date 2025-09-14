class Experience {
  final String company;
  final String position;
  final String startDate;
  final String? endDate;
  final List<String> responsibilities;
  final List<String> technologies;
  final bool isCurrent;

  const Experience({
    required this.company,
    required this.position,
    required this.startDate,
    this.endDate,
    required this.responsibilities,
    required this.technologies,
    required this.isCurrent,
  });
}
