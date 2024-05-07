import 'package:flutter/material.dart';
import '../../core/constants/constants_exports.dart';
import '../../core/shared/widgets/decorators/index.dart';
import '../widgets/widget_exports.dart';

class MainHeaderScreen extends StatefulWidget {
  const MainHeaderScreen({super.key});

  @override
  State<MainHeaderScreen> createState() => _MainHeaderScreenState();
}

class _MainHeaderScreenState extends State<MainHeaderScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<double> _logoOpacity;
  late Animation<double> _titleOpacity;
  late Animation<double> _descOpacity;

  @override
  bool get wantKeepAlive =>
      true; // Important for keeping state alive in ListView

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    setupAnimations();
    _controller.forward();
  }

  void setupAnimations() {
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.40, curve: Curves.easeIn)),
    );
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.34, 0.60, curve: Curves.easeIn)),
    );
    _descOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.67, 0.90, curve: Curves.easeIn)),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Must call super.build
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          children: [
            const GradientContainer(
              firstGradientColor: AppColors.secondaryColor,
              secondGradientColor: AppColors.primaryColor,
              myChild: HomeNavigation(),
            ),
            GradientContainer(
              firstGradientColor: AppColors.secondaryColor,
              secondGradientColor: AppColors.primaryColor,
              myHeight: 350,
              myWidth: double.infinity,
              myContainerBorderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              myChild: buildStack(),
            ),
          ],
        );
      },
    );
  }

  Widget buildStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            'lib/assets/images/style/home.jpeg',
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(.2),
          ),
        ),
        Positioned(
          top: 1,
          child: Opacity(
            opacity: _logoOpacity.value,
            child: CircleAvatar(
              maxRadius: 50,
              backgroundColor: Colors.white,
              child: Image.asset(
                'lib/assets/images/icons/app-logo.png',
                height: 80,
              ),
            ),
          ),
        ),
        Positioned(
          top: 120,
          child: Opacity(
            opacity: _titleOpacity.value,
            child: Text(
              AppTexts.welcome,
              textAlign: TextAlign.center,
              style: Styles.style20White,
            ),
          ),
        ),
        Positioned(
          top: 150,
          child: Opacity(
            opacity: _descOpacity.value,
            child: Text(
              AppTexts.welcomeDesc,
              textAlign: TextAlign.center,
              style: Styles.style20White,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
