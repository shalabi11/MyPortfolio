import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.black,
      child: Column(
        children: [
          const Text(
            'Get in Touch',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Feel free to reach out for collaborations or just a friendly chat!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // جهزنا رابط الإيميل مع موضوع الرسالة
              String emailUri =
                  'mailto:alshalabi311@gmail.com?subject=Contact%20from%20your%20Portfolio';
              _launchURL(emailUri);
            },
            child: Text(
              'alshalabi311@gmail.com',
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
                onPressed: () {
                  _launchURL('https://github.com/shalabi11');
                },
                iconSize: 30,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.linkedin),
                onPressed: () {
                  _launchURL(
                    'https://www.linkedin.com/in/ibrahim-al-shalabi-8a2b0a268?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
                  );
                },
                iconSize: 30,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.facebook),
                onPressed: () {
                  _launchURL('https://www.facebook.com/share/1LaWB4aUw7/');
                },
                iconSize: 30,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.whatsapp),
                onPressed: () {
                  _launchURL('https://wa.me/qr/GHSDHTGADMT6P1');
                },
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
