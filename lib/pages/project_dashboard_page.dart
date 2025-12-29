import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/models/project_db_model.dart';
import 'package:my_portfolio/services/project_database_service.dart';
import 'package:my_portfolio/widgets/dashboard/add_edit_project_dialog.dart';
import 'package:my_portfolio/widgets/dashboard/projects_list_view.dart';
import 'package:my_portfolio/widgets/dashboard/search_filter_bar.dart';

class ProjectDashboardPage extends StatefulWidget {
  const ProjectDashboardPage({super.key});

  @override
  State<ProjectDashboardPage> createState() => _ProjectDashboardPageState();
}

class _ProjectDashboardPageState extends State<ProjectDashboardPage> {
  late List<ProjectDb> _allProjects;
  late List<ProjectDb> _filteredProjects;
  String _searchQuery = '';
  String? _selectedTechnology;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  void _loadProjects() {
    _allProjects = ProjectDatabaseService.getProjectsSortedByDate();
    _applyFilters();
  }

  void _applyFilters() {
    _filteredProjects = _allProjects;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredProjects = ProjectDatabaseService.searchProjects(_searchQuery);
    }

    // Apply technology filter
    if (_selectedTechnology != null && _selectedTechnology!.isNotEmpty) {
      _filteredProjects = _filteredProjects
          .where((project) =>
              project.technologies.any((tech) =>
                  tech.toLowerCase() == _selectedTechnology!.toLowerCase()))
          .toList();
    }

    setState(() {});
  }

  void _handleSearch(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _handleTechnologyFilter(String? technology) {
    _selectedTechnology = technology;
    _applyFilters();
  }

  void _openAddProjectDialog() {
    showDialog(
      context: context,
      builder: (context) => AddEditProjectDialog(
        onSave: (project) {
          _loadProjects();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Project added successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  void _openEditProjectDialog(ProjectDb project) {
    showDialog(
      context: context,
      builder: (context) => AddEditProjectDialog(
        project: project,
        onSave: (updatedProject) {
          _loadProjects();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Project updated successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  void _deleteProject(String projectId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Project'),
        content: const Text('Are you sure you want to delete this project?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ProjectDatabaseService.deleteProject(projectId);
              _loadProjects();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Project deleted successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SelectableText(
          'Project Dashboard',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                        'Projects (${_filteredProjects.length})',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add Project'),
                        onPressed: _openAddProjectDialog,
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
                    onSearch: _handleSearch,
                    onTechnologyChanged: _handleTechnologyFilter,
                    technologies:
                        ProjectDatabaseService.getAllTechnologies(),
                  ),
                  const SizedBox(height: 20),

                  // Projects list
                  _filteredProjects.isEmpty
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
                          projects: _filteredProjects,
                          onEdit: _openEditProjectDialog,
                          onDelete: _deleteProject,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
