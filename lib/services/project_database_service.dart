import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_portfolio/models/project_db_model.dart';
import 'package:uuid/uuid.dart';

class ProjectDatabaseService {
  static const String projectBoxName = 'projects';
  static late Box _projectBox;

  /// Initialize Hive and open the projects box
  static Future<void> initialize() async {
    await Hive.initFlutter();
    _projectBox = await Hive.openBox(projectBoxName);
  }

  /// Get all projects
  static List<ProjectDb> getAllProjects() {
    final projects = <ProjectDb>[];
    for (var key in _projectBox.keys) {
      final data = _projectBox.get(key);
      if (data is Map) {
        projects.add(ProjectDb.fromJson(Map<String, dynamic>.from(data)));
      }
    }
    return projects;
  }

  /// Get project by ID
  static ProjectDb? getProjectById(String id) {
    try {
      final projects = getAllProjects();
      return projects.firstWhere((project) => project.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Add a new project
  static Future<ProjectDb> addProject({
    required String title,
    required String description,
    required List<String> technologies,
    required String projectUrl,
    String? galleryUrl,
    String? appDistributionUrl,
    List<String> featureImagePaths = const [],
    String? localImagePath,
  }) async {
    final project = ProjectDb(
      id: const Uuid().v4(),
      title: title,
      description: description,
      technologies: technologies,
      projectUrl: projectUrl,
      galleryUrl: galleryUrl,
      appDistributionUrl: appDistributionUrl,
      featureImagePaths: featureImagePaths,
      dateAdded: DateTime.now(),
      dateModified: DateTime.now(),
      localImagePath: localImagePath,
    );

    await _projectBox.put(project.id, project.toJson());
    return project;
  }

  /// Update existing project
  static Future<void> updateProject(ProjectDb project) async {
    final updatedProject = project.copyWith(
      dateModified: DateTime.now(),
    );
    await _projectBox.put(project.id, updatedProject.toJson());
  }

  /// Delete project by ID
  static Future<void> deleteProject(String id) async {
    await _projectBox.delete(id);
  }

  /// Delete all projects
  static Future<void> deleteAllProjects() async {
    await _projectBox.clear();
  }

  /// Search projects by title or description
  static List<ProjectDb> searchProjects(String query) {
    final lowerQuery = query.toLowerCase();
    final projects = getAllProjects();
    return projects
        .where((project) =>
            project.title.toLowerCase().contains(lowerQuery) ||
            project.description.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Filter projects by technology
  static List<ProjectDb> filterByTechnology(String technology) {
    final projects = getAllProjects();
    return projects
        .where((project) =>
            project.technologies.any((tech) =>
                tech.toLowerCase() == technology.toLowerCase()))
        .toList();
  }

  /// Get unique technologies from all projects
  static List<String> getAllTechnologies() {
    final technologies = <String>{};
    final projects = getAllProjects();
    for (var project in projects) {
      technologies.addAll(project.technologies);
    }
    return technologies.toList()..sort();
  }

  /// Get projects sorted by date added (newest first)
  static List<ProjectDb> getProjectsSortedByDate() {
    final projects = getAllProjects();
    projects.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
    return projects;
  }

  /// Export all projects as JSON
  static List<Map<String, dynamic>> exportProjectsAsJson() {
    final projects = getAllProjects();
    return projects.map((p) => p.toJson()).toList();
  }

  /// Import projects from JSON
  static Future<void> importProjectsFromJson(
      List<Map<String, dynamic>> jsonProjects) async {
    for (var jsonProject in jsonProjects) {
      final project = ProjectDb.fromJson(jsonProject);
      await _projectBox.put(project.id, jsonProject);
    }
  }

  /// Close the database
  static Future<void> close() async {
    await _projectBox.close();
  }
}
