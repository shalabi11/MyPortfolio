import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/config/personal_data.dart';
import 'package:my_portfolio/utils/url_launcher_util.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewMyWorkTap;
  const HeroSection({super.key, required this.onViewMyWorkTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.fitWidth,
            child: SelectableText(
              PersonalData.name,
              style: GoogleFonts.montserrat(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const SelectableText(
            PersonalData.title,
            style: TextStyle(fontSize: 20, color: Colors.white70),
          ),
          const SizedBox(height: 15),
          SelectableText(
            PersonalData.description,
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
                onPressed: () => launchURL(PersonalData.cvUrl),
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
