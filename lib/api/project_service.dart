import 'package:flutter/foundation.dart';
import 'package:my_portfolio/models/project_model.dart';
import 'package:my_portfolio/services/project_database_service.dart';

class ProjectService {
  /// Fetch projects from local database, with fallback to JSON
  Future<List<Project>> fetchProjects() async {
    try {
      // First, try to get projects from local database
      final dbProjects = ProjectDatabaseService.getAllProjects();
      
      if (dbProjects.isNotEmpty) {
        // Convert database projects to Project model
        return dbProjects
            .map((dbProject) => Project(
                  title: dbProject.title,
                  description: dbProject.description,
                  projectUrl: dbProject.projectUrl,
                  galleryUrl: dbProject.galleryUrl,
                  technologies: dbProject.technologies,
                  features: const [],
                  appDistributionUrl: dbProject.appDistributionUrl,
                ))
            .toList();
      }

      // Fallback: load from JSON if database is empty
      return await _loadProjectsFromJson();
    } catch (e) {
      _debugPrintError('Error loading projects: $e');
      // Final fallback: try JSON
      try {
        return await _loadProjectsFromJson();
      } catch (jsonError) {
        _debugPrintError('Error loading from JSON: $jsonError');
        return [];
      }
    }
  }

  /// Load projects from JSON asset (for migration or fallback)
  Future<List<Project>> _loadProjectsFromJson() async {
    throw UnimplementedError(
        'JSON loading removed - using database instead');
  }
}

void _debugPrintError(String message) {
  assert(() {
    debugPrint('[ERROR] $message');
    return true;
  }());
}
