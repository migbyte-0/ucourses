// lib/data/repositories/course_repository_impl.dart

import '../../../data/data_source/remote/firebase_remote_datasource.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/course_repository.dart';
import '../models/course_model.dart';

class CourseRepositoryImpl implements CourseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  CourseRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Course>> getCourses() {
    return remoteDataSource.getCourses();
  }

 @override  // Assuming CourseModel extends Course or there is a method to convert Course to CourseModel
Future<Course> addCourse(Course course) async {
  CourseModel courseModel = CourseModel.fromCourse(course);  // Convert Course to CourseModel
  return remoteDataSource.addCourse(courseModel);
}


  @override
  Future<void> editCourse(String courseId, Course course) async {
    CourseModel courseModel = CourseModel.fromCourse(course);
    await remoteDataSource.editCourse(courseId, courseModel);
  }

  @override
  Future<void> deleteCourse(String courseId) {
    return remoteDataSource.deleteCourse(courseId);
  } @override
  Future<Course> getCourseById(String courseId) async {
    final courseModel = await remoteDataSource.getCourseById(courseId);
    return courseModel;
  }
}
