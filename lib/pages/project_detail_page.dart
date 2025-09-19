import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/models/project_model.dart';
import 'package:my_portfolio/widgets/shared/feature_section.dart';
import 'package:my_portfolio/widgets/shared/sidebar_content.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;
  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SelectableText(project.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    project.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SelectableText(
                    project.description,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                  const Divider(height: 40, color: Colors.grey),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: project.features.length,
                    itemBuilder: (context, index) {
                      final feature = project.features[index];
                      return FeatureSection(
                        title: feature.title,
                        description: feature.description,
                        imagePaths: feature.imagePaths,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 30),
                  ),
                  const Divider(height: 40, color: Colors.grey),
                  SidebarContent(project: project),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
