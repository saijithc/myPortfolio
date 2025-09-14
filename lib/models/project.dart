class Project {
  final String title;
  final String description;
  final String longDescription;
  final List<String> technologies;
  final String imageUrl;
  final String githubUrl;
  final String? liveUrl;
  final List<String> features;

  const Project({
    required this.title,
    required this.description,
    required this.longDescription,
    required this.technologies,
    required this.imageUrl,
    required this.githubUrl,
    this.liveUrl,
    required this.features,
  });
}
