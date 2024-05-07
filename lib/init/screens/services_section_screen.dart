import 'package:flutter/material.dart';
import 'package:ucourses/core/constants/app_text.dart';
import '../widgets/widget_exports.dart';

class ServicesSectionScreen extends StatefulWidget {
  const ServicesSectionScreen({super.key});

  @override
  State<ServicesSectionScreen> createState() => _ServicesSectionScreenState();
}

class _ServicesSectionScreenState extends State<ServicesSectionScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<double> _imageTranslation;
  late Animation<double> _imageOpacity;
  late Animation<double> _titleTranslation;
  late Animation<double> _titleOpacity;
  late Animation<double> _descriptionTranslation;
  late Animation<double> _descriptionOpacity;

  @override
  bool get wantKeepAlive => true;  // Important to keep the state alive

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    setupAnimations();
    _controller.forward();
  }

  void setupAnimations() {
    _imageTranslation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.33, curve: Curves.easeOut)),
    );
    _imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.33, curve: Curves.easeIn)),
    );
    _titleTranslation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.34, 0.67, curve: Curves.easeOut)),
    );
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.34, 0.67, curve: Curves.easeIn)),
    );
    _descriptionTranslation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.68, 1.0, curve: Curves.easeOut)),
    );
    _descriptionOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.68, 1.0, curve: Curves.easeIn)),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // This is needed for AutomaticKeepAliveClientMixin
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Transform.translate(
            offset: Offset(0, _imageTranslation.value),
            child: Opacity(
              opacity: _imageOpacity.value,
              child: const ServicesSection(
                serviceImage: 'lib/assets/images/icons/first_service.png',
                title: AppTexts.serviceOne,
                description: AppTexts.serviceOneDesc,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, _titleTranslation.value),
            child: Opacity(
              opacity: _titleOpacity.value,
              child: const ServicesSection(
                serviceImage: 'lib/assets/images/icons/second_service.png',
                title: AppTexts.serviceTwo,
                description: AppTexts.serviceTwoDesc,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, _descriptionTranslation.value),
            child: Opacity(
              opacity: _descriptionOpacity.value,
              child: const ServicesSection(
                serviceImage: 'lib/assets/images/icons/third_service.png',
                title: AppTexts.serviceThree,
                description: AppTexts.serviceThreeDesc,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
