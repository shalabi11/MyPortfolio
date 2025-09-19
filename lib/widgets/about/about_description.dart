import 'package:flutter/material.dart';
import 'package:my_portfolio/config/personal_data.dart';

class AboutDescription extends StatelessWidget {
  const AboutDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SelectableText(
          PersonalData.aboutMeDescription,
          style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.6),
        ),
        const SizedBox(height: 25),
        const SelectableText(
          'My Skills:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        SelectableText(
          PersonalData.skills.map((skill) => '• $skill').join('\n'),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 25),
        const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.blueAccent),
            SizedBox(width: 10),
            Expanded(
              child: SelectableText(
                PersonalData.problemSolvingSkill,
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
