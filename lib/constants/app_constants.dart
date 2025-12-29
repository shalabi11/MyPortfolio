/// Application-wide constants
class AppConstants {
  // Responsive breakpoints
  static const double mobileBreakpoint = 768.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;

  // Spacing and sizing
  static const double defaultPadding = 30.0;
  static const double smallPadding = 15.0;
  static const double largePadding = 50.0;

  // Border radius
  static const double defaultBorderRadius = 15.0;
  static const double smallBorderRadius = 10.0;

  // Animation durations
  static const Duration shortDuration = Duration(milliseconds: 300);
  static const Duration mediumDuration = Duration(milliseconds: 500);
  static const Duration longDuration = Duration(seconds: 1);

  // Image quality and assets
  static const int imageQuality = 80;
  static const String placeholderImage = 'assets/images/placeholder.png';

  // Routes
  static const String homeRoute = '/';
  static const String projectDetailRoute = '/project';
}
