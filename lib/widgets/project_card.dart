import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  // ... دالة _launchURL تبقى كما هي

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => _isHovered = !_isHovered),
      onHover: (isHovering) => setState(() => _isHovered = isHovering),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: _isHovered ? 10 : 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          // استخدام ClipRRect لجعل كل المحتوى يتبع حواف البطاقة
          borderRadius: BorderRadius.circular(15.0),
          child: AspectRatio(
            // <-- أهم إضافة: فرض أبعاد الصورة
            aspectRatio: 9 / 16, // نسبة أبعاد شاشة الموبايل (عرض 9 وارتفاع 16)
            child: Stack(
              children: [
                // الطبقة 1: الصورة (تملأ المساحة بالكامل)
                Positioned.fill(
                  child: Image.asset(
                    widget.project.imagePath,
                    fit: BoxFit.cover, // cover مناسب هنا لأن الأبعاد مضبوطة
                  ),
                ),
                // الطبقة 2: طبقة التعتيم
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.1),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.title,
                        style: GoogleFonts.montserrat(/* ... */),
                      ),
                      const SizedBox(height: 10),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _isHovered
                            ? _buildDetailsView()
                            : _buildDescriptionView(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  Widget _buildDescriptionView() {
    return Text(
      widget.project.description,
      key: const ValueKey('description'),
      style: const TextStyle(color: Colors.white70, fontSize: 16),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDetailsView() {
    return Column(
      key: const ValueKey('details'),
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: widget.project.technologies.map((tech) {
            return Chip(
              label: Text(tech),
              backgroundColor: Colors.blueGrey[700],
              labelStyle: const TextStyle(color: Colors.white),
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
              onPressed: () => _launchURL(widget.project.projectUrl),
            ),
            if (widget.project.galleryUrl != null)
              OutlinedButton.icon(
                icon: const Icon(Icons.visibility, size: 18),
                label: const Text('View Project'),
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/project', // اسم المسار فقط
                  arguments: widget.project, // تمرير البيانات هنا
                ),
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
