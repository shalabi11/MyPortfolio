import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // سنحتاجه للأيقونات
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

  IconData _getTechnologyIcon(String technology) {
    switch (technology.toLowerCase()) {
      case 'flutter':
        return FontAwesomeIcons.mobileScreen;
      case 'firebase':
        return FontAwesomeIcons.fire;
      case 'dart':
        return FontAwesomeIcons.code;
      case 'bloc':
        return FontAwesomeIcons.cubes;
      case 'supabase':
        return FontAwesomeIcons.database;
      default:
        return FontAwesomeIcons.microchip;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => _isHovered = !_isHovered),
      onHover: (isHovering) => setState(() => _isHovered = isHovering),
      child: Card(
        elevation: _isHovered ? 10 : 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    widget.project.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _isHovered ? 1.0 : 0.0,
                    child: Container(
                      width: double.infinity,
                      height: 175,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.link),
                            color: Colors.white,
                            iconSize: 50,
                            onPressed: () =>
                                _launchURL(widget.project.projectUrl),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.project.technologies
                                .map(
                                  (tech) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Icon(
                                      _getTechnologyIcon(tech),
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                widget.project.title,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Text(
                  widget.project.description,
                  style: const TextStyle(color: Colors.white70),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
