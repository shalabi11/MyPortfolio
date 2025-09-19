import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/models/project_model.dart';
import 'package:my_portfolio/api/project_service.dart';
import 'package:my_portfolio/widgets/project/project_card.dart';
import 'package:my_portfolio/widgets/project/project_list_item.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = ProjectService().fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          SelectableText(
            'My Projects',
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          FutureBuilder<List<Project>>(
            future: _projectsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                return const SelectableText(
                  'Could not load projects at the moment.',
                );
              }

              final projects = snapshot.data!;

              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 768) {
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
