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

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => _isHovered = !_isHovered),
      onHover: (isHovering) => setState(() => _isHovered = isHovering),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: _isHovered ? 10 : 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(widget.project.imagePath, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.4),
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
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
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
    );
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
        // ▼▼▼ هنا الإصلاح ▼▼▼
        Wrap(
          // استخدام Wrap بدلاً من Row
          spacing: 8.0, // مسافة أفقية بين الأزرار
          runSpacing: 10.0, // مسافة عمودية في حال نزول زر لسطر جديد
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
                onPressed: () => _launchURL(widget.project.galleryUrl!),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
              ),
          ],
        ),
        // ▲▲▲ انتهى الإصلاح ▲▲▲
      ],
    );
  }
}
