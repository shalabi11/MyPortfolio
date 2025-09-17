import 'package:flutter/material.dart';
import 'package:my_portfolio/models/project_model.dart'; // تأكد من استيراد النموذج
import 'package:my_portfolio/pages/home_page.dart';
import 'package:my_portfolio/pages/project_detail_page.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String projectDetailRoute = '/project';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case projectDetailRoute:
        // استقبل المشروع كاملاً كـ argument
        final project = settings.arguments as Project;
        return MaterialPageRoute(
          builder: (_) => ProjectDetailPage(project: project),
        );

      case homeRoute:
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
