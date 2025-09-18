import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';
import 'package:transparent_image/transparent_image.dart'; // <-- أضف هذا السطر

class ProjectListItem extends StatelessWidget {
  final Project project;
  const ProjectListItem({super.key, required this.project});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    // --- الإصلاح: جلب الصورة الرئيسية بشكل صحيح ---
    final bool hasFeaturesWithImages =
        project.features.isNotEmpty &&
        project.features.first.imagePaths.isNotEmpty;

    final String mainImagePath = hasFeaturesWithImages
        ? project.features.first.imagePaths.first
        : 'assets/images/placeholder.png'; // تأكد من وجود صورة احتياطية بهذا المسار

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          // الجزء الأيسر: الصورة بعرض ثابت
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
                  child: FadeInImage(
                    // <-- 2. استبدل Image.asset بهذا
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage(mainImagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // الجزء الأيمن: التفاصيل
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    project.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    project.description,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: project.technologies.map((tech) {
                      return Chip(
                        label: Text(tech),
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
                        onPressed: () => _launchURL(project.projectUrl),
                      ),
                      if (project.galleryUrl != null)
                        OutlinedButton.icon(
                          icon: const Icon(Icons.visibility, size: 18),
                          label: const Text('View Project'),
                          onPressed: () async {
                            // <-- 1. اجعل الدالة async
                            await Future.delayed(
                              const Duration(milliseconds: 50),
                            ); // <-- 2. أضف التأخير
                            if (context.mounted) {
                              // <-- 3. تأكد أن الويدجت ما زال موجودًا
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
