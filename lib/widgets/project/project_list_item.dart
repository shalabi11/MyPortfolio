import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/utils/url_launcher_util.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/project_model.dart';
import 'package:transparent_image/transparent_image.dart';

class ProjectListItem extends StatelessWidget {
  final Project project;
  const ProjectListItem({super.key, required this.project});

  // Future<void> _launchURL(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (!await launchUrl(uri)) throw 'Could not launch $url';
  // }

  @override
  Widget build(BuildContext context) {
    final bool hasFeaturesWithImages =
        project.features.isNotEmpty &&
        project.features.first.imagePaths.isNotEmpty;

    final String mainImagePath = hasFeaturesWithImages
        ? project.features.first.imagePaths.first
        : 'assets/images/placeholder.png';

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(color: Colors.grey[900]),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[800]!, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: mainImagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(
                    project.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    project.description,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: project.technologies.map((tech) {
                      return Chip(
                        label: SelectableText(tech),
                        backgroundColor: Colors.blueGrey[700],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      ElevatedButton.icon(
                        icon: const FaIcon(FontAwesomeIcons.github, size: 16),
                        label: const Text('GitHub'),
                        onPressed: () => launchURL(project.projectUrl),
                      ),
                      if (project.galleryUrl != null)
                        OutlinedButton.icon(
                          icon: const Icon(Icons.visibility, size: 18),
                          label: const Text('View Project'),
                          onPressed: () async {
                            await Future.delayed(
                              const Duration(milliseconds: 50),
                            );
                            if (context.mounted) {
                              Navigator.pushNamed(
                                context,
                                '/project',
                                arguments: project,
                              );
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
