import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/about_section.dart';
import 'package:my_portfolio/widgets/contact_section.dart';
import 'package:my_portfolio/widgets/custom_app_bar.dart';
import 'package:my_portfolio/widgets/footer.dart';
import 'package:my_portfolio/widgets/hero_section.dart';
import 'package:my_portfolio/widgets/project_section.dart';
import 'package:animate_do/animate_do.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  Future<void> _scrollToSection(GlobalKey key) async {
    final context = key.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onHomeTap: () => _scrollToSection(_heroKey),
        onProjectsTap: () => _scrollToSection(_projectsKey),
        onAboutTap: () => _scrollToSection(_aboutKey),
        onContactTap: () => _scrollToSection(_contactKey),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 40, 40, 40)),
              child: Text(
                ' ',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pop();
                _scrollToSection(_heroKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.apps, color: Colors.white),
              title: const Text(
                'Projects',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _scrollToSection(_projectsKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('About', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pop();
                _scrollToSection(_aboutKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.white),
              title: const Text(
                'Contact',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _scrollToSection(_contactKey);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(
              key: _heroKey,
              onViewMyWorkTap: () => _scrollToSection(_projectsKey),
            ),
            FadeInUp(child: ProjectsSection(key: _projectsKey)),
            FadeInUp(child: AboutSection(key: _aboutKey)),
            FadeInUp(child: ContactSection(key: _contactKey)),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
