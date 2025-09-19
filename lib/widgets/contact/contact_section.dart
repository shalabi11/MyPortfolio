import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/config/personal_data.dart';
import 'package:my_portfolio/utils/url_launcher_util.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.black,
      child: Column(
        children: [
          const SelectableText(
            'Get in Touch',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const SelectableText(
            'Feel free to reach out for collaborations or just a friendly chat!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              String emailUri =
                  'mailto:${PersonalData.contactEmail}?subject=Contact%20from%20your%20Portfolio';
              launchURL(emailUri);
            },
            child: Text(
              PersonalData.contactEmail,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[300],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.github),
                onPressed: () => launchURL(PersonalData.githubUrl),
                iconSize: 30,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.linkedin),
                onPressed: () => launchURL(PersonalData.linkedinUrl),
                iconSize: 30,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.facebook),
                onPressed: () => launchURL(PersonalData.facebookUrl),
                iconSize: 30,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.whatsapp),
                onPressed: () => launchURL(PersonalData.whatsappUrl),
                iconSize: 30,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
