import 'package:flutter/material.dart';
import 'package:my_portfolio/data/project_data.dart';
import 'package:my_portfolio/pages/home_page.dart';
import 'package:my_portfolio/pages/project_detail_page.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String projectDetailRoute = '/project';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');

    if (uri.path == projectDetailRoute) {
      // استخراج اسم المشروع من الرابط (e.g., /project?title=Faculty App)
      final projectTitle = uri.queryParameters['title'];
      if (projectTitle != null) {
        // البحث عن المشروع في قائمة البيانات
        final project = projects.firstWhere(
          (p) => p.title == projectTitle,
          orElse: () => projects.first,
        );
        return MaterialPageRoute(
          builder: (_) => ProjectDetailPage(project: project),
        );
      }
    }

    // إذا لم يتم العثور على أي مسار، اذهب إلى الصفحة الرئيسية
    return MaterialPageRoute(builder: (_) => const HomePage());
  }
}
