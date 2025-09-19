import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class FeatureSection extends StatelessWidget {
  final String title;
  final String description;
  final List<String> imagePaths;

  const FeatureSection({
    super.key,
    required this.title,
    required this.description,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SelectableText(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 400,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imagePaths[index],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ),
        ),
      ],
    );
  }
}
