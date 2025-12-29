import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/project_model.dart';

class ProjectService {
  Future<List<Project>> fetchProjects() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/projects.json',
      );
      final data = await json.decode(response) as List;
      return data.map((projectJson) {
        return Project.fromJson(projectJson as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      _debugPrintError('Error loading projects: $e');
      return [];
    }
  }
}

void _debugPrintError(String message) {
  // This will only print in debug mode
  assert(() {
    print('[ERROR] $message');
    return true;
  }());
}
