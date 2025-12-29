import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_portfolio/models/project_db_model.dart';
import 'package:uuid/uuid.dart';

class ProjectDatabaseService {
  static const String projectBoxName = 'projects';
  static late Box<ProjectDb> _projectBox;

  /// Initialize Hive and open the projects box
  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProjectDbAdapter());
    _projectBox = await Hive.openBox<ProjectDb>(projectBoxName);
  }

  /// Get all projects
  static List<ProjectDb> getAllProjects() {
    return _projectBox.values.toList();
  }

  /// Get project by ID
  static ProjectDb? getProjectById(String id) {
    try {
      return _projectBox.values.firstWhere((project) => project.id == id);
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

    await _projectBox.put(project.id, project);
    return project;
  }

  /// Update existing project
  static Future<void> updateProject(ProjectDb project) async {
    final updatedProject = project.copyWith(
      dateModified: DateTime.now(),
    );
    await _projectBox.put(project.id, updatedProject);
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
    return _projectBox.values
        .where((project) =>
            project.title.toLowerCase().contains(lowerQuery) ||
            project.description.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Filter projects by technology
  static List<ProjectDb> filterByTechnology(String technology) {
    return _projectBox.values
        .where((project) =>
            project.technologies.any((tech) =>
                tech.toLowerCase() == technology.toLowerCase()))
        .toList();
  }

  /// Get unique technologies from all projects
  static List<String> getAllTechnologies() {
    final technologies = <String>{};
    for (var project in _projectBox.values) {
      technologies.addAll(project.technologies);
    }
    return technologies.toList()..sort();
  }

  /// Get projects sorted by date added (newest first)
  static List<ProjectDb> getProjectsSortedByDate() {
    final projects = _projectBox.values.toList();
    projects.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
    return projects;
  }

  /// Export all projects as JSON
  static List<Map<String, dynamic>> exportProjectsAsJson() {
    return _projectBox.values.map((p) => p.toJson()).toList();
  }

  /// Import projects from JSON
  static Future<void> importProjectsFromJson(
      List<Map<String, dynamic>> jsonProjects) async {
    for (var jsonProject in jsonProjects) {
      final project = ProjectDb.fromJson(jsonProject);
      await _projectBox.put(project.id, project);
    }
  }

  /// Get project box for reactive updates (if using ValueListenableBuilder)
  static Box<ProjectDb> getProjectBox() {
    return _projectBox;
  }

  /// Close the database
  static Future<void> close() async {
    await _projectBox.close();
  }
}
