import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/app_router.dart';
import 'package:my_portfolio/pages/home_page.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.white),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.homeRoute,
    );
  }
}
