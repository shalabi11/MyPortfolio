// lib/widgets/footer.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.black,
      child: Center(
        child: Text(
          '© ${DateTime.now().year} Ibrahim Al Shalabi • Built with Flutter',
          style: GoogleFonts.lato(color: Colors.white70, fontSize: 14),
        ),
      ),
    );
  }
}
