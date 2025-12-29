import 'package:flutter/material.dart';
import 'package:my_portfolio/models/project_model.dart';
import 'package:my_portfolio/pages/home_page.dart';
import 'package:my_portfolio/pages/project_detail_page.dart';
import 'package:my_portfolio/pages/project_dashboard_page.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String projectDetailRoute = '/project';
  static const String dashboardRoute = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case projectDetailRoute:
        final project = settings.arguments as Project;
        return MaterialPageRoute(
          builder: (_) => ProjectDetailPage(project: project),
        );

      case dashboardRoute:
        return MaterialPageRoute(
          builder: (_) => const ProjectDashboardPage(),
        );

      case homeRoute:
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
