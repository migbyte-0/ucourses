import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ucourses/core/constants/app_colors.dart';
import 'package:ucourses/core/constants/app_text.dart';
import 'package:ucourses/core/constants/app_text_styles.dart';
import 'package:ucourses/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ucourses/features/admin/presentation/cubit/admin_state.dart';
import 'package:ucourses/features/student/domain/entities/course_entity.dart';
import '../../../../core/shared/widgets/style/lottie_loading.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Course course;

  const CourseDetailsScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: Text(course.title),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 10,
                child: CachedNetworkImage(
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: course.images,
                  placeholder: (context, url) => const LottieLoading(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: 50,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                AppTexts.courseTitle,
                style: Styles.styleBold,
              ),
              const SizedBox(height: 5),
              Text(
                course.title,
                style: Styles.style16,
              ),
              const SizedBox(height: 20),
              const Text(
                AppTexts.courseDescripition,
                style: Styles.styleBold,
              ),
              const SizedBox(height: 5),
              Text(
                course.description,
                style: Styles.style16,
              ),
              const SizedBox(height: 20),
              const Text(
                AppTexts.courseContent,
                style: Styles.styleBold,
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  course.content,
                  style: Styles.style16,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                AppTexts.courseRating,
                style: Styles.styleBold,
              ),
              const SizedBox(height: 5),
         
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<AdminCubit>().fetchQuizzes(course.id);
                  },
                  icon: const Icon(Icons.quiz),
                  label: Text(
                    AppTexts.takeQuiz,
                    style: Styles.style16White,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.thirdColor,
                  ),
                ),
              ),
              BlocListener<AdminCubit, AdminState>(
                listener: (context, state) {
                  if (state is QuizzesLoaded) {
                    if (state.quizzes.isNotEmpty) {
                      final quiz = state.quizzes.first;
                      Navigator.pushNamed(context, '/quiz', arguments: quiz);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("No quizzes available for this course")),
                      );
                    }
                  } else if (state is AdminError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
