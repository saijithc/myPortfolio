class Skill {
  final String name;
  final String category;
  final int proficiency; // 1-100
  final String imagePath;
 final bool? shouldAddColor;

   Skill({
    required this.name,
    required this.category,
    required this.proficiency,
    required this.imagePath,
    this.shouldAddColor = false,
  });
}
