import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ucourses/core/constants/app_text_styles.dart';
import 'package:ucourses/core/constants/constants_exports.dart';
import 'package:ucourses/core/shared/widgets/decorators/diagonal_clipper.dart';
import 'package:ucourses/core/shared/widgets/decorators/gradient_container_widget.dart';
import 'package:ucourses/features/student/presentation/cubit/student_cubit.dart';

class CertificateScreen extends StatelessWidget {
  final int score;

  const CertificateScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        String studentName = 'Unknown';
        if (state is StudentLoggedIn) {
          studentName = state.student.username;
        }

        String message;
        String lottieAnimation;

        if (score == 0) {
          message = 'للأسف لم تنجح، حاول مرة أخرى!';
          lottieAnimation = 'lib/assets/jsons/animation/error.json';
        } else {
          message = AppTexts.congratsMsg;
          lottieAnimation = 'lib/assets/jsons/animation/certificate.json';
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: [
              ClipPath(
                clipper: DiagonalClipper(),
                child: const GradientContainer(
                    firstGradientColor: AppColors.thirdColor,
                    secondGradientColor: AppColors.fourthColor),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Lottie.asset(
                                  lottieAnimation,
                                  height: 100,
                                  width: 100,
                                  repeat: false,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                studentName,
                                style: Styles.style18,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: Styles.style15grey,
                              ),
                              const SizedBox(height: 20),
                              const Divider(),
                              const Text(
                                AppTexts.yourScore,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '$score',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: score == 0 ? Colors.red : Colors.green,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed('/courses'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  AppTexts.finish,
                                  style: Styles.style16White,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
