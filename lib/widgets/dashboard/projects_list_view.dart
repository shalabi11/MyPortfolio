import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/models/project_db_model.dart';

class ProjectsListView extends StatelessWidget {
  final List<ProjectDb> projects;
  final Function(ProjectDb) onEdit;
  final Function(String) onDelete;

  const ProjectsListView({
    super.key,
    required this.projects,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          // Mobile view
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            itemBuilder: (context, index) =>
                _buildProjectCard(context, projects[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          );
        } else {
          // Desktop view - Grid
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) =>
                _buildProjectCard(context, projects[index]),
          );
        }
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, ProjectDb project) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            if (project.localImagePath != null &&
                File(project.localImagePath!).existsSync())
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Image.file(
                    File(project.localImagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[800],
                ),
                child: const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            const SizedBox(height: 12),

            // Project Title
            SelectableText(
              project.title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 8),

            // Project Description
            SelectableText(
              project.description,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
                height: 1.4,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 8),

            // Technologies
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: project.technologies.take(3).map((tech) {
                return Chip(
                  label: Text(tech, style: const TextStyle(fontSize: 11)),
                  backgroundColor: Colors.blueGrey[700],
                  labelStyle: const TextStyle(color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                );
              }).toList(),
            ),
            if (project.technologies.length > 3)
              SelectableText(
                '+${project.technologies.length - 3} more',
                style: const TextStyle(fontSize: 11, color: Colors.white70),
              ),
            const SizedBox(height: 8),

            // Date added
            SelectableText(
              'Added: ${project.dateAdded.toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 11, color: Colors.white70),
            ),
            const Spacer(),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                    onPressed: () => onEdit(project),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete, size: 16),
                    label: const Text('Delete'),
                    onPressed: () => onDelete(project.id),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
