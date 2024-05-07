import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ucourses/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:ucourses/features/quiz/data/datasources/quiz_datasource.dart';
import 'package:ucourses/features/quiz/data/repositories/quiz_repo_impl.dart';
import 'package:ucourses/features/quiz/domain/entities/quiz.dart';
import 'package:ucourses/features/quiz/presentation/screens/certificate_screen.dart';
import 'package:ucourses/features/student/presentation/cubit/course_cubit.dart';
import 'package:ucourses/features/student/presentation/cubit/student_cubit.dart';
import 'package:ucourses/features/student/presentation/screens/courses_screen.dart';
import 'package:ucourses/features/student/presentation/screens/student_profile_screen.dart';
import 'package:ucourses/features/admin/presentation/screens/admin_courses_screen.dart';
import 'package:ucourses/features/admin/presentation/screens/admin_student_list_screen.dart';
import 'package:ucourses/features/admin/presentation/screens/admin_profile_screen.dart';
import 'package:ucourses/features/student/presentation/screens/student_register_screen.dart';
import 'package:ucourses/init/login_screen.dart';
import 'package:ucourses/main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../features/admin/data/datasources/AdminDataSourceImpl.dart';
import '../features/admin/data/repositories/admin_repository_impl.dart';
import '../features/admin/domain/usecases/admin_use_cases.dart';
import '../features/admin/presentation/cubit/admin_auth_cubit.dart';
import '../features/admin/presentation/cubit/admin_profile_cubit.dart';
import '../features/data/data_source/remote/firebase_remote_datasource.dart';
import '../features/quiz/presentation/screens/quiz_screen.dart';
import '../features/student/data/repositories/course_repository_impl.dart';
import '../features/student/data/repositories/student_repository_impl.dart';
import '../features/student/domain/entities/course_entity.dart';
import '../features/student/domain/usecases/course_use_cases.dart';
import '../features/student/domain/usecases/student_use_cases.dart';
import '../features/student/presentation/cubit/student_list_cubit.dart';
import '../features/student/presentation/screens/course_details_screen.dart';
import '../features/admin/presentation/screens/admin_login_screen.dart';
import 'home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseRemoteDataSource firebaseRemoteDataSource =
        FirebaseRemoteDataSource();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final quizDataSource = QuizDataSource(firestore);
    final quizRepository = QuizRepositoryImpl(quizDataSource);

    // Initialize repositories
    final studentRepository = StudentRepositoryImpl(firebaseRemoteDataSource);
    final courseRepository = CourseRepositoryImpl(firebaseRemoteDataSource);
    final adminDataSource = AdminDataSourceImpl();
    final adminRepository = AdminRepositoryImpl(adminDataSource);

    // Initialize use cases
    final studentUseCases =
        StudentUseCases(studentRepository, firebaseRemoteDataSource);
    final courseUseCases = CourseUseCases(courseRepository);
    final adminUseCases =
        AdminUseCases(adminRepository, courseRepository, firebaseAuth);

    return MultiBlocProvider(
      providers: [
        BlocProvider<StudentCubit>(
          create: (context) => StudentCubit(studentUseCases, courseUseCases),
        ),
        BlocProvider<CourseCubit>(
          create: (context) => CourseCubit(courseUseCases),
        ),
        BlocProvider<AdminCubit>(
          create: (context) => AdminCubit(adminUseCases, quizRepository, courseUseCases),
        ),
        BlocProvider<AdminAuthCubit>(
          create: (context) => AdminAuthCubit(adminUseCases),
        ),
        BlocProvider<AdminProfileCubit>(
          create: (context) => AdminProfileCubit(adminUseCases),
        ),
        BlocProvider(
          create: (context) => AdminAuthCubit(adminUseCases),
          child: const AdminLoginScreen(),
        ),
        BlocProvider<StudentListCubit>(
          // Ensure StudentListCubit is provided
          create: (context) => StudentListCubit(studentUseCases),
        ),
      ],
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        title: 'UCourses',
        // locale: const Locale('ar', 'AE'),
        // supportedLocales: const [
        //   Locale('en', 'US'),
        //   Locale('ar', 'AE'),
        // ],
        // localizationsDelegates:  const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // localeResolutionCallback: (locale, supportedLocales) {
        //   if (locale != null && supportedLocales.contains(locale)) {
        //     return locale;
        //   }
        //   return const Locale('ar', 'AE');
        // },
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/home': (context) => HomeScreen(),
          '/courses': (context) => const CoursesScreen(),
          '/student_profile': (context) => const StudentProfileScreen(),
          '/register': (context) => const StudentRegisterScreen(),
          '/quiz': (context) => QuizScreen(
              quiz: ModalRoute.of(context)!.settings.arguments as Quiz),
          '/courseDetails': (context) => CourseDetailsScreen(
              course: ModalRoute.of(context)!.settings.arguments as Course),
          '/admin_courses': (context) => const AdminCoursesScreen(),
          '/admin_students': (context) => const AdminStudentListScreen(),
          '/admin_profile': (context) => const AdminProfileScreen(),
          '/admin_login': (context) => const AdminLoginScreen(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
