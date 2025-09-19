import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/widgets/about/about_description.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: const Color.fromARGB(255, 25, 25, 25),
      child: Column(
        children: [
          SelectableText(
            'About Me',
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 768) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage(
                        'assets/images/profile_picture.jpg',
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(child: const AboutDescription()),
                  ],
                );
              } else {
                return Column(
                  children: [
                    const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(
                        'assets/images/profile_picture.jpg',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const AboutDescription(),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
