import 'package:flutter/material.dart';
import 'package:ucourses/core/constants/constants_exports.dart';
import 'package:ucourses/init/screens/main_header_screen.dart';
import 'screens/carousel_screen.dart';
import 'screens/footer_screen.dart';
import 'screens/services_section_screen.dart';
import 'screens/testimonial_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> _widgets = [
    const MainHeaderScreen(),
    const SizedBox(height: 50),
    const Divider(thickness: 1),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(AppTexts.courses,
          textAlign: TextAlign.center, style: Styles.style22),
    ),
    const HomeCarousel(),
    const SizedBox(height: 70),
    const Divider(thickness: 1),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
      child: Text(AppTexts.services,
          textAlign: TextAlign.center, style: Styles.style22),
    ),
    const ServicesSectionScreen(),
    const SizedBox(height: 70),
    const Divider(thickness: 1),
    const SizedBox(height: 60),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(AppTexts.testimonials,
          textAlign: TextAlign.center, style: Styles.style22),
    ),
    const SizedBox(height: 30),
    TestimonialsScreen(),
    const SizedBox(height: 70),
    const FooterScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _widgets.length,
        itemBuilder: (context, index) => _widgets[index],
      ),
    );
  }
}
