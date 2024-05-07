import 'package:flutter/material.dart';
import 'package:ucourses/init/login_screen.dart';

import '../../core/constants/app_text.dart';
import '../../core/constants/app_text_styles.dart';
import '../home_screen.dart';
import '../screens/about_screen.dart';
import '../screens/contact_us_screen.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            child: Text(
              AppTexts.home,
              style: Styles.style16White,
            )),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Text(
              AppTexts.login,
              style: Styles.style16White,
            )),
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
            )),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ContactUsScreen(),
                ),
              );
            },
            child: Text(
              AppTexts.contactUs,
              style: Styles.style16White,
            )),
      ],
    );
  }
}
