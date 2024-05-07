import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:ucourses/core/constants/app_colors.dart';
import 'package:ucourses/core/constants/app_text_styles.dart';
import 'package:ucourses/core/shared/widgets/decorators/gradient_container_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_text.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Helper method to launch URL using the new API
    void launchWhatsApp(String phoneNumber, String message) async {
      var url = Uri.parse(
          'https://wa.me/${phoneNumber.replaceAll('+', '')}?text=${Uri.encodeComponent(message)}');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Could not launch WhatsApp'),
        ));
      }
    }

    return Scaffold(
      body: GradientContainer(
        firstGradientColor: AppColors.thirdColor,
        secondGradientColor: AppColors.primaryColor,
        myChild: Card(
          margin:
              const EdgeInsets.only(top: 60, left: 50, right: 50, bottom: 30),
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Lottie.asset('lib/assets/jsons/animation/contact-us.json',
                  height: 150, width: 150, repeat: false),
              const Text(
                AppTexts.contactUs,
                style: Styles.style18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebookF),
                    color: Colors.blue,
                    iconSize: 40,
                    onPressed: () {/* Handle your onPressed */},
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.whatsapp),
                    color: Colors.greenAccent,
                    iconSize: 40,
                    onPressed: () {
                      launchWhatsApp('+966544024948',
                          'السلام عليكم ورحمة الله , ابي استفسر عن دورة');
                    },
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram),
                    color: Colors.purple,
                    iconSize: 40,
                    onPressed: () {/* Handle your onPressed */},
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.twitter),
                    color: Colors.blueAccent,
                    iconSize: 40,
                    onPressed: () {/* Handle your onPressed */},
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.google),
                    color: Colors.green,
                    iconSize: 40,
                    onPressed: () {/* Handle your onPressed */},
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.youtube),
                    color: Colors.red,
                    iconSize: 40,
                    onPressed: () {/* Handle your onPressed */},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
