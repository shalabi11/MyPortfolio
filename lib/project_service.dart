import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/project_model.dart';

class ProjectService {
  Future<List<Project>> fetchProjects() async {
    try {
      // 1. قراءة الملف من assets
      final String response = await rootBundle.loadString(
        'assets/projects.json',
      );
      // 2. تحويل النص إلى JSON
      final data = await json.decode(response) as List;
      // 3. تحويل JSON إلى قائمة مشاريع باستخدام الـ factory constructor
      return data.map((projectJson) {
        return Project.fromJson(projectJson as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      // في حال حدوث خطأ، اطبع الخطأ وأرجع قائمة فارغة
      print('Error loading projects: $e');
      return [];
    }
  }
}
