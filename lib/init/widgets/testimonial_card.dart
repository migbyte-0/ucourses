import 'package:flutter/material.dart';
import 'package:ucourses/core/constants/app_text_styles.dart';
import 'testimonial_item.dart'; // Ensure this import points to the correct file

class TestimonialCard extends StatefulWidget {
  final Testimonial testimonial;
  final double width;
  final double height;

  const TestimonialCard({
    super.key,
    required this.testimonial,
    this.width = 350, // Default width if not specified
    this.height = 400, // Default height if not specified
  });

  @override
  State<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<TestimonialCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _imageTranslation;
  late Animation<double> _imageOpacity;
  late Animation<double> _nameTranslation;
  late Animation<double> _nameOpacity;
  late Animation<double> _majorTranslation;
  late Animation<double> _majorOpacity;
  late Animation<double> _testimonialTranslation;
  late Animation<double> _testimonialOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define the animation for the image
    _imageTranslation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.25, curve: Curves.easeOut)),
    );
    _imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.25, curve: Curves.easeIn)),
    );

    // Define the animation for the name
    _nameTranslation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.25, 0.5, curve: Curves.easeOut)),
    );
    _nameOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.25, 0.5, curve: Curves.easeIn)),
    );

    // Define the animation for the major
    _majorTranslation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 0.75, curve: Curves.easeOut)),
    );
    _majorOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 0.75, curve: Curves.easeIn)),
    );

    // Define the animation for the testimonial
    _testimonialTranslation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.75, 1.0, curve: Curves.easeOut)),
    );
    _testimonialOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.75, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: Card(
            elevation: 5.0,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0, _imageTranslation.value),
                    child: Opacity(
                      opacity: _imageOpacity.value,
                      child: CircleAvatar(
                        radius: 50,
                        child: Icon(
                          widget.testimonial.icon,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Transform.translate(
                    offset: Offset(0, _nameTranslation.value),
                    child: Opacity(
                      opacity: _nameOpacity.value,
                      child:
                          Text(widget.testimonial.name, style: Styles.style18),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Transform.translate(
                    offset: Offset(0, _majorTranslation.value),
                    child: Opacity(
                      opacity: _majorOpacity.value,
                      child: Text(widget.testimonial.major,
                          style: Styles.style15grey),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Transform.translate(
                    offset: Offset(0, _testimonialTranslation.value),
                    child: Opacity(
                      opacity: _testimonialOpacity.value,
                      child: Text(
                        widget.testimonial.testimonial,
                        textAlign: TextAlign.center,
                        style: Styles.style16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
