import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/models/project_model.dart';
import 'package:my_portfolio/project_service.dart';
import 'package:my_portfolio/widgets/project_card.dart';
import 'package:my_portfolio/widgets/project_list_item.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  // متغير لتخزين نتيجة جلب المشاريع
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    // طلب المشاريع عند بدء تشغيل الويدجت
    _projectsFuture = ProjectService().fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Text(
            'My Projects',
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          // استخدام FutureBuilder لعرض البيانات بعد تحميلها
          FutureBuilder<List<Project>>(
            future: _projectsFuture,
            builder: (context, snapshot) {
              // عرض إشارة تحميل أثناء انتظار البيانات
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              // عرض رسالة خطأ في حال فشل التحميل
              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                return const Text('Could not load projects at the moment.');
              }

              final projects = snapshot.data!;

              // عرض الواجهة بعد تحميل البيانات بنجاح
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 768) {
                    // تصميم الموبايل
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: projects.length,
                      itemBuilder: (ctx, index) =>
                          ProjectCard(project: projects[index]),
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(height: 20),
                    );
                  } else {
                    // تصميم اللابتوب
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: projects.length,
                      itemBuilder: (ctx, index) =>
                          ProjectListItem(project: projects[index]),
                      separatorBuilder: (ctx, index) =>
                          const SizedBox(height: 20),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
