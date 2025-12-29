import 'package:flutter/material.dart';
import 'package:my_portfolio/models/project_model.dart';
import 'package:my_portfolio/pages/home_page.dart';
import 'package:my_portfolio/pages/project_detail_page.dart';
import 'package:my_portfolio/pages/project_dashboard_page.dart';
import 'package:my_portfolio/pages/login_page.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String projectDetailRoute = '/project';
  static const String dashboardRoute = '/dashboard';
  static const String loginRoute = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case projectDetailRoute:
        final project = settings.arguments as Project;
        return MaterialPageRoute(
          builder: (_) => ProjectDetailPage(project: project),
        );

      case dashboardRoute:
        // Check authentication before allowing access to dashboard
        return _buildAuthenticatedRoute(
          (_) => const ProjectDashboardPage(),
          settings,
        );

      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case homeRoute:
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }

  /// Build a route that checks authentication
  static Route<dynamic> _buildAuthenticatedRoute(
    WidgetBuilder builder,
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (context) {
        // This will be wrapped with auth check in main.dart
        return builder(context);
      },
      settings: settings,
    );
  }
}

