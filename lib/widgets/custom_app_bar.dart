import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;

  const CustomAppBar({
    super.key,
    required this.onHomeTap,
    required this.onProjectsTap,
    required this.onAboutTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          'Ibrahim moussa al shalabi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      actions: <Widget>[
        if (screenWidth > 768)
          Row(
            children: [
              TextButton(
                onPressed: onHomeTap,
                child: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: onProjectsTap,
                child: const Text(
                  'Projects',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              // === الزر الذي كان مفقودًا ===
              TextButton(
                onPressed: onAboutTap,
                child: const Text(
                  'About',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // ============================
              const SizedBox(width: 10),
              TextButton(
                onPressed: onContactTap,
                child: const Text(
                  'Contact',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 20),
            ],
          )
        else
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
