import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// تأكد من استيراد كل الحزم الأخرى التي تحتاجها
import '../models/project_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;
  const ProjectDetailPage({super.key, required this.project});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(project.title),
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
                  Text(
                    project.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
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
                      return _buildFeatureSection(
                        title: feature.title,
                        description: feature.description,
                        imagePaths: feature.imagePaths,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 30),
                  ),
                  const Divider(height: 40, color: Colors.grey),
                  _buildSidebarContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ويدجت بناء الفقرة (تم تعديله)
  Widget _buildFeatureSection({
    required String title,
    required String description,
    required List<String> imagePaths,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),

        // --- التعديل الرئيسي: المعرض الأفقي ---
        SizedBox(
          height: 400, // تحديد ارتفاع ثابت للمعرض
          child: ListView.separated(
            scrollDirection: Axis.horizontal, // جعله أفقيًا
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0), // مسافة بين الصور
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(imagePaths[index]),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ),
        ),
      ],
    );
  }

  // ويدجت لبناء قسم التقنيات والروابط
  Widget _buildSidebarContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
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
              label: Text(tech),
              backgroundColor: Colors.blueGrey[800],
            );
          }).toList(),
        ),
        const SizedBox(height: 30),
        Text(
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
              onPressed: () => _launchURL(project.projectUrl),
            ),
            if (project.galleryUrl != null)
              OutlinedButton.icon(
                icon: const Icon(Icons.visibility, size: 18),
                label: const Text('Live Demo'),
                onPressed: () => _launchURL(project.galleryUrl!),
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
