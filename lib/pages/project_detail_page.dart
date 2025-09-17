import 'package:flutter/material.dart';
import '../models/project_model.dart'; // سنحتاج لنموذج المشروع

class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(project.title), // عنوان الصفحة هو اسم المشروع
      ),
      body: Center(
        child: Text('Details for ${project.title} will be shown here.'),
      ),
    );
  }
}
