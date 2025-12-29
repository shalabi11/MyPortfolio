import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url, {BuildContext? context}) async {
  try {
    final Uri uri = Uri.parse(url);
    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open: $url'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  } catch (e) {
    debugPrint('Error launching URL: $e');
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error opening link. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
