import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/app_router.dart';
import 'package:my_portfolio/pages/project_dashboard_page.dart';
import 'package:my_portfolio/services/project_database_service.dart';
import 'package:my_portfolio/services/auth_service.dart';
import 'package:my_portfolio/providers/auth_provider.dart';
import 'package:my_portfolio/widgets/dashboard/add_edit_project_dialog.dart';
import 'package:my_portfolio/models/project_db_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProjectDatabaseService.initialize();
  await AuthService().initialize();
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider()..initialize(),
      child: MaterialApp(
        title: 'My Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ).apply(bodyColor: Colors.white),
        ),
        onGenerateRoute: (settings) {
          // Intercept dashboard route to check authentication
          if (settings.name == AppRouter.dashboardRoute) {
            return MaterialPageRoute(
              builder: (context) {
                return Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    if (authProvider.isLoading) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (!authProvider.isAuthenticated) {
                      // Redirect to login if not authenticated
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacementNamed(
                          AppRouter.loginRoute,
                        );
                      });
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    // User is authenticated, show dashboard
                    return const _DashboardWithLogout();
                  },
                );
              },
              settings: settings,
            );
          }

          // For other routes, use the standard router
          return AppRouter.generateRoute(settings);
        },
        initialRoute: AppRouter.homeRoute,
      ),
    );
  }
}

/// Dashboard wrapper with logout button in app bar
class _DashboardWithLogout extends StatefulWidget {
  const _DashboardWithLogout();

  @override
  State<_DashboardWithLogout> createState() => _DashboardWithLogoutState();
}

class _DashboardWithLogoutState extends State<_DashboardWithLogout> {
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
          .where(
            (project) => project.technologies.any(
              (tech) =>
                  tech.toLowerCase() == _selectedTechnology!.toLowerCase(),
            ),
          )
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

  Future<void> _deleteProject(String projectId) async {
    return showDialog(
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
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              onPressed: () async {
                await context.read<AuthProvider>().logout();
                if (context.mounted) {
                  Navigator.of(context).pushReplacementNamed(
                    AppRouter.homeRoute,
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: ProjectDashboardPageContent(
        filteredProjects: _filteredProjects,
        allTechnologies: ProjectDatabaseService.getAllTechnologies(),
        onSearch: _handleSearch,
        onTechnologyFilter: _handleTechnologyFilter,
        onAddProject: _openAddProjectDialog,
        onEditProject: _openEditProjectDialog,
        onDeleteProject: _deleteProject,
      ),
    );
  }
}
