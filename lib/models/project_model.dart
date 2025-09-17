// lib/models/project_model.dart

class Project {
  final String imagePath;
  final String title;
  final String description;
  final String projectUrl;
  final List<String> technologies;

  Project({
    required this.technologies,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.projectUrl,
  });
}
