import 'package:flutter/material.dart';
import 'package:ucourses/core/constants/app_text.dart';

import '../widgets/testimonial_card.dart';
import '../widgets/testimonial_item.dart'; // Ensure these imports point to correct files

class TestimonialsScreen extends StatelessWidget {
  TestimonialsScreen({super.key});

  final List<Testimonial> testimonials = [
    Testimonial(
      icon: Icons.person,
      name: AppTexts.testimonialNameOne,
      major: 'طالب علوم تقنية',
      testimonial: AppTexts.testimonialOne,
    ),
    Testimonial(
      icon: Icons.person,
      name: AppTexts.testimonialNameTwo,
      major: 'طالب علوم حاسب الي',
      testimonial: AppTexts.testimonialThree,
    ),
    Testimonial(
      icon: Icons.person,
      name: AppTexts.testimonialNameThree,
      major: 'طالب ميكانيكا',
      testimonial: AppTexts.testimonialTwo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: testimonials
                .map((testimonial) => TestimonialCard(testimonial: testimonial))
                .toList(),
          ),
        ),
      ),
    );
  }
}
