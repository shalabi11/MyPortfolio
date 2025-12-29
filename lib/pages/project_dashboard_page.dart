import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/models/project_db_model.dart';
import 'package:my_portfolio/widgets/dashboard/projects_list_view.dart';
import 'package:my_portfolio/widgets/dashboard/search_filter_bar.dart';

/// Exported content widget for use in main.dart with custom AppBar
class ProjectDashboardPageContent extends StatelessWidget {
  final List<ProjectDb> filteredProjects;
  final List<String> allTechnologies;
  final Function(String) onSearch;
  final Function(String?) onTechnologyFilter;
  final VoidCallback onAddProject;
  final Function(ProjectDb) onEditProject;
  final Function(String) onDeleteProject;

  const ProjectDashboardPageContent({
    super.key,
    required this.filteredProjects,
    required this.allTechnologies,
    required this.onSearch,
    required this.onTechnologyFilter,
    required this.onAddProject,
    required this.onEditProject,
    required this.onDeleteProject,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with add button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectableText(
                      'Projects (${filteredProjects.length})',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Project'),
                      onPressed: onAddProject,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search and filter bar
                SearchFilterBar(
                  onSearch: onSearch,
                  onTechnologyChanged: onTechnologyFilter,
                  technologies: allTechnologies,
                ),
                const SizedBox(height: 20),

                // Projects list
                filteredProjects.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: SelectableText(
                            'No projects found. Add your first project!',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      )
                    : ProjectsListView(
                        projects: filteredProjects,
                        onEdit: onEditProject,
                        onDelete: onDeleteProject,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Legacy widget for compatibility - now use ProjectDashboardPageContent directly
class ProjectDashboardPage extends StatelessWidget {
  const ProjectDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // This page is now handled by main.dart with authentication
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
