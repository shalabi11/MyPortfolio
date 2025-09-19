import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/models/project_model.dart';
import 'package:my_portfolio/utils/url_launcher_util.dart';

class SidebarContent extends StatelessWidget {
  final Project project;
  const SidebarContent({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          'Tech Stack',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: project.technologies.map((tech) {
            return Chip(
              label: SelectableText(tech),
              backgroundColor: Colors.blueGrey[800],
            );
          }).toList(),
        ),
        const SizedBox(height: 30),
        SelectableText(
          'Links',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              icon: const FaIcon(FontAwesomeIcons.github, size: 16),
              label: const Text('GitHub'),
              onPressed: () => launchURL(project.projectUrl),
            ),
            if (project.galleryUrl != null)
              OutlinedButton.icon(
                icon: const Icon(Icons.visibility, size: 18),
                label: const Text('Live Demo'),
                onPressed: () => launchURL(project.galleryUrl!),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
              ),
            if (project.appDistributionUrl != null)
              OutlinedButton.icon(
                icon: const Icon(Icons.phone_android, size: 18),
                label: const Text('Download Beta'),
                onPressed: () => launchURL(project.appDistributionUrl!),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
