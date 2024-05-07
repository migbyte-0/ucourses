import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ucourses/core/constants/app_colors.dart';
import 'package:ucourses/core/constants/app_text.dart';
import 'package:ucourses/core/constants/app_text_styles.dart';
import 'package:ucourses/core/shared/widgets/decorators/gradient_container_widget.dart';
import 'package:ucourses/init/home_screen.dart';
import 'package:ucourses/init/login_screen.dart';
import 'package:ucourses/init/screens/about_screen.dart';
import 'package:ucourses/init/screens/contact_us_screen.dart'; // Make sure to add font_awesome_flutter to your pubspec.yaml

class FooterScreen extends StatelessWidget {
  const FooterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      firstGradientColor: AppColors.secondaryColor,
      secondGradientColor: AppColors.primaryColor,
      myChild: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Social Media Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.facebookF),
                color: Colors.white,
                onPressed: () {/* Handle your onPressed */},
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram),
                color: Colors.white,
                onPressed: () {/* Handle your onPressed */},
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.twitter),
                color: Colors.white,
                onPressed: () {/* Handle your onPressed */},
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.google),
                color: Colors.white,
                onPressed: () {/* Handle your onPressed */},
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.youtube),
                color: Colors.white,
                onPressed: () {/* Handle your onPressed */},
              ),
            ],
          ),
          const SizedBox(height: 20), // Space between icons and navigation
          // Navigation Links Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  );
                },
                child: Text(
                  AppTexts.about,
                  style: Styles.style16White,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ContactUsScreen(),
                    ),
                  );
                },
                child: Text(AppTexts.contactUs, style: Styles.style16White),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Text(AppTexts.login, style: Styles.style16White),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Text(AppTexts.home, style: Styles.style16White),
              ),
            ],
          ),
          const SizedBox(height: 20), // Space between navigation and copyright
          Text(
            'حقوق النشر ©2024؛ صمم من قبل المجموعة الثانية',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
