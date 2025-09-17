import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: const Color.fromARGB(255, 25, 25, 25),
      child: Column(
        children: [
          Text(
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
                    Expanded(child: _buildDescription()),
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
                    _buildDescription(),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'I am a Flutter developer specializing in building scalable and user-friendly mobile applications. '
          'I enjoy transforming ideas into real products, from concept and design to deployment. '
          'My focus is on clean architecture, performance optimization, and delivering a seamless user experience.',
          style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.6),
        ),
        SizedBox(height: 25),

        Text(
          'My Skills:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '• Flutter & Dart (Cross-platform development)\n'
          '• State Management: Bloc, Riverpod\n'
          '• Backend Integration: Firebase, Supabase, REST APIs\n'
          '• Database: SQLite, Hive\n'
          '• Tools: Git, GitHub, Figma, Postman',
          style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
        ),
        SizedBox(height: 25),

        // Row(
        //   children: [
        //     Icon(Icons.check_circle, color: Colors.blueAccent),
        //     SizedBox(width: 10),
        //     Expanded(
        //       child: Text(
        //         'Contributed to university projects like CollegeHub app, with features such as schedules, authentication, and notifications.',
        //         style: TextStyle(
        //           fontSize: 15,
        //           color: Colors.white70,
        //           height: 1.4,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.blueAccent),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Strong problem-solving skills, teamwork spirit, and passion for continuous learning.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
