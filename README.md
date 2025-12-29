# Ibrahim Al Shalabi's Portfolio

A responsive Flutter web portfolio showcasing projects, skills, and experience.

## Features

- 🎨 **Responsive Design** - Optimized for mobile, tablet, and desktop
- 🚀 **Fast Performance** - Deployed with image compression and asset optimization
- 📱 **Project Showcase** - Interactive project cards with detailed feature galleries
- 🔗 **Easy Navigation** - Smooth scroll navigation to different sections
- 💬 **Social Links** - Direct links to GitHub, LinkedIn, Facebook, WhatsApp, and email

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── app_router.dart          # Route configuration
├── api/
│   └── project_service.dart # Load projects from JSON
├── config/
│   └── personal_data.dart   # Personal information and constants
├── constants/
│   └── app_constants.dart   # Application-wide constants
├── models/
│   ├── project_model.dart   # Project data model
│   └── project_feature_model.dart
├── pages/
│   ├── home_page.dart       # Main portfolio page
│   └── project_detail_page.dart
├── utils/
│   └── url_launcher_util.dart # URL launching with error handling
└── widgets/
    ├── home/                # Hero section and app bar
    ├── project/             # Project cards and listings
    ├── about/               # About me section
    ├── contact/             # Contact information
    └── shared/              # Reusable widgets
```

## Getting Started

### Prerequisites
- Flutter SDK 3.35.4 or higher
- Dart SDK 3.8.1 or higher

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/shalabi11/MyPortfolio.git
   cd my_portfolio
   ```

2. Get dependencies
   ```bash
   flutter pub get
   ```

3. Run the application
   ```bash
   flutter run -d chrome
   ```

### Building for Web

```bash
flutter build web --release --base-href /MyPortfolio/
```

## Deployment

The project uses GitHub Actions for automatic deployment to GitHub Pages.

### Workflow Features:
- ✅ Automatic build on push to main branch
- ✅ Code analysis with `flutter analyze`
- ✅ Image optimization (WebP conversion)
- ✅ Asset compression (gzip and brotli)
- ✅ Automatic deployment to gh-pages

## Dependencies

- **UI Framework**: Flutter & Material Design
- **Fonts**: google_fonts
- **Icons**: font_awesome_flutter
- **Animations**: animate_do
- **Image Loading**: transparent_image
- **URL Launching**: url_launcher
- **Image Compression**: flutter_image_compress

## Key Sections

### 📍 Home/Hero Section
Displays name, title, and call-to-action buttons for CV download and project viewing.

### 📁 Projects Section
- Responsive grid/list view of projects
- Interactive cards with technology stack
- Detailed project pages with feature galleries

### 👤 About Section
Personal information, skills, and background with profile picture.

### 📧 Contact Section
Social media links and email contact options.

## Performance Optimizations

- **Lazy Loading**: Images use FadeInImage with placeholders
- **Responsive Design**: Uses LayoutBuilder for adaptive layouts
- **Asset Compression**: Automated gzip and brotli compression
- **Image Formats**: WebP conversion for smaller file sizes
- **Caching**: Flutter pub cache enabled in CI/CD

## Author

**Ibrahim Al Shalabi**
- 🔗 [GitHub](https://github.com/shalabi11)
- 💼 [LinkedIn](https://www.linkedin.com/in/ibrahim-al-shalabi-8a2b0a268)
- 📧 [Email](mailto:alshalabi311@gmail.com)

## License

This project is open source and available under the MIT License.

## Contributing

Feel free to fork this project and customize it for your own portfolio!

