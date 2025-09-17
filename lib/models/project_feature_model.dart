// lib/models/project_feature_model.dart

class ProjectFeature {
  final String title;
  final String description;
  final List<String> imagePaths;

  ProjectFeature({
    required this.title,
    required this.description,
    this.imagePaths = const [],
  });
  factory ProjectFeature.fromJson(Map<String, dynamic> json) {
    return ProjectFeature(
      title: json['title'] as String,
      description: json['description'] as String,
      imagePaths: List<String>.from(json['imagePaths'] as List),
    );
  }
}
