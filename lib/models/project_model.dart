// lib/models/project_model.dart

import 'package:my_portfolio/models/project_feature_model.dart';

class Project {
  final String title;
  final String description;
  final String projectUrl;
  final List<String> technologies;
  final String? galleryUrl;
  final List<ProjectFeature> features;

  Project({
    this.technologies = const [],

    required this.title,
    required this.description,
    required this.projectUrl,
    this.galleryUrl,
    this.features = const [],
  });
  factory Project.fromJson(Map<String, dynamic> json) {
    var featuresFromJson = json['features'] as List? ?? [];
    List<ProjectFeature> featureList = featuresFromJson
        .map((f) => ProjectFeature.fromJson(f as Map<String, dynamic>))
        .toList();

    return Project(
      title: json['title'] as String,
      description: json['description'] as String,
      projectUrl: json['projectUrl'] as String,
      galleryUrl: json['galleryUrl'] as String?,
      technologies: List<String>.from(json['technologies'] as List),
      features: featureList,
    );
  }
}
