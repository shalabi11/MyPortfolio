import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewMyWorkTap;
  const HeroSection({super.key, required this.onViewMyWorkTap});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Ibrahim al shalabi',
              style: GoogleFonts.montserrat(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Flutter Developer || Software Engineer',
            style: TextStyle(fontSize: 20, color: Colors.white70),
          ),

          const SizedBox(height: 15),
          Text(
            'I build robust software solutions and high-performance applications.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(fontSize: 18, color: Colors.white70),
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onViewMyWorkTap,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text('View My Work'),
              ),
              const SizedBox(width: 20),
              OutlinedButton.icon(
                icon: const Icon(Icons.download, size: 18),
                label: const Text('Download CV'),
                onPressed: () {
                  _launchURL(
                    'https://drive.google.com/file/d/1JN1y9jAPPBE7us0bItflPh9Tj6Ks0VHm/view?usp=drivesdk',
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  side: const BorderSide(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
