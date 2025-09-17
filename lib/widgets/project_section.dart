import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/data/project_data.dart';
import 'package:my_portfolio/widgets/project_card.dart';
import 'package:my_portfolio/widgets/project_list_item.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 768) {
                // --- تصميم شاشة الموبايل الجديد (قائمة عمودية) ---
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    // نستخدم نفس تصميم البطاقة التفاعلية
                    return ProjectCard(project: projects[index]);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                );
              } else {
                // --- تصميم شاشة اللابتوب (يبقى كما هو) ---
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return ProjectListItem(project: projects[index]);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
